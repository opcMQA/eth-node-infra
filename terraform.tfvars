# GCP Project Configuration
project_id = "starlit-brand-446515-p8"
region     = "us-east1"
zone       = "us-east1-b"

# Network Configuration
network_name = "eth-node-network"
subnet_name  = "eth-node-subnet"
subnet_cidr  = "10.0.0.0/24"

# Instance Configuration
instance_name = "eth-node"
machine_type  = "n2-standard-4"
disk_size_gb  = 1024
disk_type     = "pd-ssd"

# Ethereum Configuration
ethereum_network = "mainnet"
ethereum_client  = "geth"

# Security Configuration
service_account_email = "your-service-account@your-project.iam.gserviceaccount.com"
enable_public_ip      = true
allowed_ip_ranges = [
  "YOUR_IP_ADDRESS/32" # Replace with your IP address
]

# Instance Tags
tags = ["eth-node", "ethereum"] 