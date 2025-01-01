#!/bin/bash

# Exit on error
set -e

# Update system
apt-get update
apt-get upgrade -y

# Install necessary packages
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    python3-pip \
    python3-dev \
    build-essential \
    git \
    jq \
    nodejs \
    npm \
    golang-go

# Install Python packages for MEV analysis
pip3 install \
    web3 \
    pandas \
    numpy \
    jupyter \
    matplotlib \
    requests \
    aiohttp \
    eth-brownie \
    eth-utils

# Mount the data disk
DATA_DISK_NAME="${data_disk_name}"
MOUNT_POINT="/var/lib/ethereum"

# Format the disk if needed
if ! blkid /dev/disk/by-id/google-$DATA_DISK_NAME; then
    mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/disk/by-id/google-$DATA_DISK_NAME
fi

# Create mount point
mkdir -p $MOUNT_POINT

# Add to fstab and mount
if ! grep -q $MOUNT_POINT /etc/fstab; then
    echo "/dev/disk/by-id/google-$DATA_DISK_NAME $MOUNT_POINT ext4 discard,defaults,nofail 0 2" >> /etc/fstab
fi
mount -a

# Set up Ethereum client
if [ "${ethereum_client}" = "geth" ]; then
    # Install Geth
    add-apt-repository -y ppa:ethereum/ethereum
    apt-get update
    apt-get install -y ethereum

    # Create systemd service with MEV-specific configurations
    cat > /etc/systemd/system/geth.service << EOF
[Unit]
Description=Ethereum go client
After=network.target
Wants=network.target

[Service]
User=ethereum
Group=ethereum
Type=simple
Restart=always
RestartSec=5
ExecStart=/usr/bin/geth \
    --${ethereum_network} \
    --datadir $MOUNT_POINT \
    --http \
    --http.addr 0.0.0.0 \
    --http.port 8545 \
    --http.api eth,net,web3,txpool,debug,trace \
    --http.vhosts=* \
    --ws \
    --ws.addr 0.0.0.0 \
    --ws.port 8546 \
    --ws.api eth,net,web3,txpool,debug,trace \
    --metrics \
    --metrics.addr 0.0.0.0 \
    --cache 8192 \
    --syncmode full \
    --txpool.globalslots 16384 \
    --txpool.globalqueue 8192 \
    --rpc.allow-unprotected-txs

[Install]
WantedBy=default.target
EOF

elif [ "${ethereum_client}" = "erigon" ]; then
    # Install Erigon
    ERIGON_VERSION=$(curl -s https://api.github.com/repos/ledgerwatch/erigon/releases/latest | jq -r .tag_name)
    curl -Lo erigon.tar.gz "https://github.com/ledgerwatch/erigon/releases/download/$ERIGON_VERSION/erigon_$ERIGON_VERSION_linux_amd64.tar.gz"
    tar xzf erigon.tar.gz
    mv erigon /usr/local/bin/
    rm erigon.tar.gz

    # Create systemd service with MEV-specific configurations
    cat > /etc/systemd/system/erigon.service << EOF
[Unit]
Description=Erigon Ethereum Client
After=network.target
Wants=network.target

[Service]
User=ethereum
Group=ethereum
Type=simple
Restart=always
RestartSec=5
ExecStart=/usr/local/bin/erigon \
    --chain=${ethereum_network} \
    --datadir $MOUNT_POINT \
    --http \
    --http.addr 0.0.0.0 \
    --http.port 8545 \
    --http.api eth,net,web3,txpool,debug,trace \
    --ws \
    --ws.addr 0.0.0.0 \
    --ws.port 8546 \
    --ws.api eth,net,web3,txpool,debug,trace \
    --metrics \
    --metrics.addr 0.0.0.0

[Install]
WantedBy=default.target
EOF
fi

# Create ethereum user and set permissions
useradd -r -s /bin/false ethereum || true
chown -R ethereum:ethereum $MOUNT_POINT

# Install MEV monitoring tools
mkdir -p /opt/mev-tools
cd /opt/mev-tools

# Install mev-geth-utils
git clone https://github.com/flashbots/mev-geth-utils.git
cd mev-geth-utils
npm install

# Install prometheus and node_exporter for monitoring
apt-get install -y prometheus prometheus-node-exporter

# Configure prometheus for MEV monitoring
cat > /etc/prometheus/prometheus.yml << EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'ethereum'
    static_configs:
      - targets: ['localhost:8545']
  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9100']
EOF

# Start services
systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus
systemctl enable prometheus-node-exporter
systemctl start prometheus-node-exporter
systemctl enable ${ethereum_client}
systemctl start ${ethereum_client}

# Create a simple health check script
cat > /usr/local/bin/check-eth-node.sh << 'EOF'
#!/bin/bash
curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' http://localhost:8545
EOF
chmod +x /usr/local/bin/check-eth-node.sh

# Set up log rotation
cat > /etc/logrotate.d/ethereum << EOF
$MOUNT_POINT/logs/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 640 ethereum ethereum
}
EOF

# Create data directories
mkdir -p $MOUNT_POINT/{logs,data}
chown -R ethereum:ethereum $MOUNT_POINT 