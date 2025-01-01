# Ethereum Full Node on GCP for MEV

This project contains Terraform configurations to deploy a full Ethereum node on Google Cloud Platform (GCP), optimized for MEV backtesting and execution.

## Architecture

### Compute Resources
- Machine Type: n2-standard-4 (4 vCPUs, 16GB memory)
- Boot Disk: 200GB SSD (Ubuntu 22.04 LTS)
- Data Disk: 1TB SSD for blockchain data
- Region: us-east1 (optimized for Ethereum network connectivity)

### Node Configuration
- Full Node (not archive node)
- Supported Clients: 
  - Geth (default)
  - Erigon
- Enhanced RPC/WS APIs with debug and trace capabilities
- Optimized cache and transaction pool settings
- Prometheus monitoring integration

### Network Configuration
- Dedicated VPC network
- Firewall rules for:
  - Ethereum P2P (30303 TCP/UDP)
  - RPC API (8545)
  - WebSocket (8546)
  - SSH access (22)

## Prerequisites

- Google Cloud Platform account
- Terraform installed (version >= 1.0.0)
- GCP project created with billing enabled
- GCP service account with necessary permissions
- `gcloud` CLI tool installed and configured

## Quick Start

1. Clone this repository
2. Update `terraform.tfvars` with your specific values:
   ```hcl
   project_id = "your-project-id"
   region     = "us-east1"
   zone       = "us-east1-b"
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the deployment plan:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

## MEV Tools and Utilities

The node comes pre-configured with:
- MEV monitoring tools
- Python environment for analysis
- Prometheus metrics
- Health check scripts
- Log rotation

### Installed Python Packages
- web3
- pandas
- numpy
- jupyter
- matplotlib
- eth-brownie
- eth-utils

## Node Management

### Accessing the Node
- RPC Endpoint: http://<node-ip>:8545
- WebSocket Endpoint: ws://<node-ip>:8546
- SSH access available with proper credentials

### Monitoring
- Prometheus metrics available on port 9090
- Node exporter metrics on port 9100
- Custom health check script at `/usr/local/bin/check-eth-node.sh`

### Data Management
- Daily snapshots configured
- 7-day snapshot retention
- Log rotation enabled
- Data mounted at `/var/lib/ethereum`

## Security Considerations

- Firewall rules limit access to specified IP ranges
- Dedicated service account with minimal permissions
- Secure API endpoints
- Regular system updates
- Isolated network configuration

## Maintenance

### Backup and Recovery
- Automated daily snapshots
- Snapshot retention policy: 7 days
- Data disk can be detached/reattached if needed

### Updates
- System configured for automatic security updates
- Node client updates must be managed manually
- Use `allow_stopping_for_update = true` for safe maintenance

## Troubleshooting

1. Check node synchronization:
   ```bash
   /usr/local/bin/check-eth-node.sh
   ```

2. View logs:
   ```bash
   journalctl -u geth.service -f
   # or
   journalctl -u erigon.service -f
   ```

3. Monitor system resources:
   ```bash
   http://<node-ip>:9090  # Prometheus
   ```

## Cost Optimization

- Uses SSD for better performance
- Snapshot policy for backup efficiency
- Resource sizing optimized for full node operation

## License

[MIT License](LICENSE)

## Support

For issues and feature requests, please open an issue in the repository. 