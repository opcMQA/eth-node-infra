variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
}

variable "region" {
  description = "The GCP region for the subnet"
  type        = string
}

variable "allowed_ip_ranges" {
  description = "List of IP ranges allowed to connect to the node"
  type        = list(string)
}

variable "network_tags" {
  description = "Network tags to reference in firewall rules"
  type        = list(string)
}
