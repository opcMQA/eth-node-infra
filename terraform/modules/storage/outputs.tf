output "disk_id" {
  description = "The ID of the created disk"
  value       = google_compute_disk.ethereum_data.id
}

output "disk_name" {
  description = "The name of the created disk"
  value       = google_compute_disk.ethereum_data.name
}

output "disk_self_link" {
  description = "The self-link of the created disk"
  value       = google_compute_disk.ethereum_data.self_link
}
