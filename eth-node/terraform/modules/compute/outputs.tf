output "instance_id" {
  description = "The ID of the instance"
  value       = google_compute_instance.ethereum_node.id
}

output "instance_name" {
  description = "The name of the instance"
  value       = google_compute_instance.ethereum_node.name
}

output "instance_self_link" {
  description = "The self-link of the instance"
  value       = google_compute_instance.ethereum_node.self_link
}

output "internal_ip" {
  description = "The internal IP address of the instance"
  value       = google_compute_instance.ethereum_node.network_interface[0].network_ip
}

output "external_ip" {
  description = "The external IP address of the instance (if enabled)"
  value       = var.enable_public_ip ? google_compute_instance.ethereum_node.network_interface[0].access_config[0].nat_ip : null
}
