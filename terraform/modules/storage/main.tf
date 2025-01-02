# Create the persistent disk for Ethereum data
resource "google_compute_disk" "ethereum_data" {
  name    = var.disk_name
  project = var.project_id
  type    = var.disk_type
  zone    = var.zone
  size    = var.disk_size_gb
  labels  = var.disk_labels

  # Enable physical block provisioning
  physical_block_size_bytes = 4096
}
