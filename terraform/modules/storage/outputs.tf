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

output "snapshot_schedule_id" {
  description = "The ID of the snapshot schedule"
  value       = google_compute_resource_policy.snapshot_schedule.id
}

output "snapshot_schedule_name" {
  description = "The name of the snapshot schedule"
  value       = google_compute_resource_policy.snapshot_schedule.name
}
