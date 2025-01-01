variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "zone" {
  description = "The GCP zone for the disk"
  type        = string
}

variable "disk_name" {
  description = "Name of the persistent disk"
  type        = string
}

variable "disk_size_gb" {
  description = "Size of the persistent disk in GB"
  type        = number
}

variable "disk_type" {
  description = "Type of the persistent disk (pd-standard, pd-ssd, or pd-balanced)"
  type        = string
}

variable "disk_labels" {
  description = "Labels to apply to the disk"
  type        = map(string)
  default     = {}
}

variable "snapshot_schedule_name" {
  description = "Name of the snapshot schedule"
  type        = string
  default     = "eth-node-snapshot-schedule"
}

variable "snapshot_retention_days" {
  description = "Number of days to retain snapshots"
  type        = number
  default     = 7
}
