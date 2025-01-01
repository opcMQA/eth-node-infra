locals {
  # Common labels to be applied to all resources
  common_labels = {
    environment = "production"
    purpose     = "ethereum-mev"
    managed_by  = "terraform"
    project     = var.project_id
  }

  # Network tags for the instance
  network_tags = concat(var.tags, ["ethereum", "mev"])

  # Compute the network CIDR for the VPC
  network_cidr = "10.0.0.0/16"

  # Compute the service account name if not provided
  service_account_name = var.service_account_email != "" ? var.service_account_email : "eth-node-sa@${var.project_id}.iam.gserviceaccount.com"

  # Compute the full disk name
  disk_name = "${var.instance_name}-data-${random_id.suffix.hex}"

  # Compute the snapshot schedule name
  snapshot_schedule = "${var.instance_name}-snapshot-${random_id.suffix.hex}"
}

# Generate a random suffix for uniqueness
resource "random_id" "suffix" {
  byte_length = 4
} 