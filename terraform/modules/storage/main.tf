# Create the persistent disk for Ethereum data
resource "google_compute_disk" "ethereum_data" {
  name    = var.disk_name
  project = var.project_id
  type    = var.disk_type
  zone    = var.zone
  size    = var.disk_size_gb
  labels  = var.disk_labels

  # Enable automatic snapshot policies
  snapshot_schedule_policy {
    schedule_policy {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "03:00"  # 3 AM UTC
      }
    }

    retention_policy {
      max_retention_days    = var.snapshot_retention_days
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
  }

  # Enable physical block provisioning for better performance
  provisioning_type = "STANDARD"

  # Enable automatic deletion of snapshots
  lifecycle {
    prevent_destroy = false
  }
}

# Create a snapshot schedule
resource "google_compute_resource_policy" "snapshot_schedule" {
  name    = var.snapshot_schedule_name
  project = var.project_id
  region  = substr(var.zone, 0, length(var.zone)-2)  # Extract region from zone

  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "03:00"
      }
    }

    retention_policy {
      max_retention_days    = var.snapshot_retention_days
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }

    snapshot_properties {
      storage_locations = [substr(var.zone, 0, length(var.zone)-2)]
      guest_flush      = true
    }
  }
}
