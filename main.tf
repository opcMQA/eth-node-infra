# Network Module
module "network" {
  source = "./terraform/modules/network"

  project_id        = var.project_id
  network_name      = var.network_name
  subnet_name       = var.subnet_name
  subnet_cidr       = var.subnet_cidr
  region            = var.region
  allowed_ip_ranges = var.allowed_ip_ranges
  network_tags      = var.tags
}

# Storage Module
module "storage" {
  source = "./terraform/modules/storage"

  project_id   = var.project_id
  zone         = var.zone
  disk_name    = "${var.instance_name}-data"
  disk_size_gb = var.disk_size_gb
  disk_type    = var.disk_type
  disk_labels = {
    environment = "production"
    purpose     = "ethereum-mev"
  }
  snapshot_schedule_name  = "${var.instance_name}-snapshot"
  snapshot_retention_days = 7
}

# Compute Module
module "compute" {
  source = "./terraform/modules/compute"

  project_id            = var.project_id
  zone                  = var.zone
  instance_name         = var.instance_name
  machine_type          = var.machine_type
  network_self_link     = module.network.network_id
  subnet_self_link      = module.network.subnet_self_link
  disk_self_link        = module.storage.disk_self_link
  service_account_email = var.service_account_email
  tags                  = var.tags
  enable_public_ip      = var.enable_public_ip
  ethereum_network      = var.ethereum_network
  ethereum_client       = var.ethereum_client
  labels = {
    environment = "production"
    purpose     = "ethereum-mev"
    network     = var.ethereum_network
    client      = var.ethereum_client
  }
}

# Outputs
output "instance_external_ip" {
  description = "The external IP address of the Ethereum node"
  value       = module.compute.external_ip
}

output "instance_internal_ip" {
  description = "The internal IP address of the Ethereum node"
  value       = module.compute.internal_ip
}

output "network_name" {
  description = "The name of the VPC network"
  value       = module.network.network_name
}

output "ethereum_data_disk" {
  description = "The name of the Ethereum data disk"
  value       = module.storage.disk_name
}

output "instance_name" {
  description = "The name of the Ethereum node instance"
  value       = module.compute.instance_name
}

output "geth_rpc_endpoint" {
  description = "The RPC endpoint for the Ethereum node"
  value       = "http://${module.compute.external_ip}:8545"
}

output "geth_ws_endpoint" {
  description = "The WebSocket endpoint for the Ethereum node"
  value       = "ws://${module.compute.external_ip}:8546"
} 