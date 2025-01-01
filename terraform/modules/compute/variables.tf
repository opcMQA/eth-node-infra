variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "zone" {
  description = "The GCP zone for the instance"
  type        = string
}

variable "instance_name" {
  description = "Name of the Ethereum node instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the instance"
  type        = string
}

variable "network_self_link" {
  description = "Self-link of the VPC network"
  type        = string
}

variable "subnet_self_link" {
  description = "Self-link of the subnet"
  type        = string
}

variable "disk_self_link" {
  description = "Self-link of the boot disk"
  type        = string
}

variable "service_account_email" {
  description = "Service account email for the instance"
  type        = string
}

variable "tags" {
  description = "Network tags to apply to the instance"
  type        = list(string)
}

variable "enable_public_ip" {
  description = "Whether to enable public IP for the instance"
  type        = bool
  default     = true
}

variable "ethereum_network" {
  description = "Ethereum network to connect to (mainnet or testnet)"
  type        = string
}

variable "ethereum_client" {
  description = "Ethereum client to use (geth or erigon)"
  type        = string
}

variable "metadata_startup_script" {
  description = "Startup script for the instance"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels to apply to the instance"
  type        = map(string)
  default     = {}
}
