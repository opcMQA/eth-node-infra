# Create the Ethereum node instance
resource "google_compute_instance" "ethereum_node" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  tags = var.tags

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-22-04-lts"
      size  = 200  # 200GB boot disk for MEV backtesting requirements
      type  = "pd-ssd"  # SSD for better performance
    }
  }

  # Attach the Ethereum data disk
  attached_disk {
    source = var.disk_self_link
    mode   = "READ_WRITE"
  }

  network_interface {
    network    = var.network_self_link
    subnetwork = var.subnet_self_link

    dynamic "access_config" {
      for_each = var.enable_public_ip ? [1] : []
      content {
        # Ephemeral public IP
      }
    }
  }

  # Use custom service account
  service_account {
    email  = var.service_account_email
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  # Metadata for startup script and SSH keys
  metadata = {
    startup-script = local.startup_script
  }

  # Allow stopping for update
  allow_stopping_for_update = true

  # Labels
  labels = merge(var.labels, {
    ethereum_network = var.ethereum_network
    ethereum_client  = var.ethereum_client
  })
}

# Local variables for startup script
locals {
  startup_script = var.metadata_startup_script != "" ? var.metadata_startup_script : templatefile(
    "${path.module}/templates/startup-script.sh.tpl",
    {
      ethereum_network = var.ethereum_network
      ethereum_client  = var.ethereum_client
      data_disk_name  = split("/", var.disk_self_link)[length(split("/", var.disk_self_link)) - 1]
    }
  )
}
