variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region where resources will be created"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "The GCP zone where resources will be created"
  type        = string
  default     = "us-east1-b"
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "eth-node-network"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "eth-node-subnet"
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "instance_name" {
  description = "Name of the Ethereum node instance"
  type        = string
  default     = "eth-node"
}

variable "machine_type" {
  description = "Machine type for the Ethereum node"
  type        = string
  default     = "n2-standard-4" # 4 vCPUs, 16GB memory
}

variable "disk_size_gb" {
  description = "Size of the persistent disk in GB"
  type        = number
  default     = 1024 # 1TB for full node
}

variable "disk_type" {
  description = "Type of the persistent disk"
  type        = string
  default     = "pd-ssd"
}

variable "ethereum_network" {
  description = "Ethereum network to connect to (mainnet or testnet)"
  type        = string
  default     = "mainnet"
}

variable "ethereum_client" {
  description = "Ethereum client to use (geth or erigon)"
  type        = string
  default     = "geth"
}

variable "service_account_email" {
  description = "Service account email for the VM instance"
  type        = string
}

variable "tags" {
  description = "Network tags to apply to the instance"
  type        = list(string)
  default     = ["eth-node"]
}

variable "enable_public_ip" {
  description = "Whether to enable public IP for the instance"
  type        = bool
  default     = true
}

variable "allowed_ip_ranges" {
  description = "List of IP ranges allowed to connect to the node"
  type        = list(string)
  default     = [] # Empty means only internal access
} 