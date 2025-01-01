# Create VPC Network
resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

# Create Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
  project       = var.project_id
}

# Firewall rule for Ethereum P2P communication
resource "google_compute_firewall" "ethereum_p2p" {
  name    = "${var.network_name}-eth-p2p"
  network = google_compute_network.vpc_network.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["30303"]  # Default Ethereum P2P port
  }

  allow {
    protocol = "udp"
    ports    = ["30303"]  # Default Ethereum P2P port
  }

  source_ranges = var.allowed_ip_ranges
  target_tags   = var.network_tags
}

# Firewall rule for RPC API (if enabled)
resource "google_compute_firewall" "ethereum_rpc" {
  name    = "${var.network_name}-eth-rpc"
  network = google_compute_network.vpc_network.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["8545", "8546"]  # Default RPC and WebSocket ports
  }

  source_ranges = var.allowed_ip_ranges
  target_tags   = var.network_tags
}

# Firewall rule for SSH access
resource "google_compute_firewall" "ssh" {
  name    = "${var.network_name}-ssh"
  network = google_compute_network.vpc_network.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.allowed_ip_ranges
  target_tags   = var.network_tags
}
