variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in (required)"
}

variable "shared_vpc_name" {
  type        = string
  description = "The shared VPC network name."
}

variable "shared_vpc_project_id" {
  type        = string
  description = "The shared VPC network project id."
}

variable "create_bastion" {
  type        = bool
  description = "Create bastion -optional."
  default     = false
}

variable "bastion_name" {
  type        = string
  description = "The zone for the bastion VM in primary region."
  default     = "bastion-gke"
}

variable "bastion_region" {
  type        = string
  description = "The zone for the bastion VM in primary region."
  default     = "us-west1"
}

variable "bastion_zone" {
  type        = string
  description = "The zone for the bastion VM in primary region."
  default     = "us-west1-b"
}

variable "bastion_subnet_name" {
  type        = string
  description = "The name of the subnet for the shared VPC."
  default     = "bastion-host-subnet"
}

variable "bastion_service_account_email" {
  type        = string
  description = "The bastion service account email"
}

variable "gke_settings" {
  type = map(object({
    name                      = string
    subnetwork                = string
    ip_range_pods             = string
    ip_range_services         = string
    master_ipv4_cidr_block    = string
    enable_external_ip        = bool
    default_max_pods_per_node = number
    region                    = string
    node_pool_min_count       = number
    node_pool_max_count       = number
    machine_type              = string
    master_authorized_networks = list(object({
      cidr_block   = string
      display_name = string
    }))
  }))
  default     = {}
  description = "Map of all the clusters configurations"
}

variable "enforce_bin_auth_policy" {
  type        = bool
  description = "Enable or Disable creation of binary authorization policy."
  default     = false
}

variable "bin_auth_attestor_names" {
  type        = list(string)
  description = "Binary Authorization Attestor Names set up in shared app_cicd project."
}

variable "attestors_keyring_id" {
  type        = string
  description = "The attestors keyring id"
}

variable "allowlist_patterns" {
  type        = list(string)
  description = "The google binary authorization policy allowlist patterns"
  default     = ["quay.io/random-containers/*", "k8s.gcr.io/more-random/*", "gcr.io/config-management-release/*"]
}
