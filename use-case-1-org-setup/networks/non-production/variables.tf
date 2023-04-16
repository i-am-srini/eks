variable "org_id" {
  type        = string
  description = "Organization ID"
}

variable "access_context_manager_policy_id" {
  type        = number
  description = "The id of the default Access Context Manager policy created in step `1-org`. Can be obtained by running `gcloud access-context-manager policies list --organization YOUR_ORGANIZATION_ID --format=\"value(name)\"`."
}

variable "terraform_service_account" {
  type        = string
  description = "Service account email of the account to impersonate to run Terraform."
}

variable "default_region1" {
  type        = string
  description = "First subnet region. The shared vpc modules only configures two regions."
}

variable "default_region2" {
  type        = string
  description = "Second subnet region. The shared vpc modules only configures two regions."
}

variable "domain" {
  type        = string
  description = "The DNS name of peering managed zone, for instance 'example.com.'. Must end with a period."
}

variable "dns_enable_logging" {
  type        = bool
  description = "Toggle DNS logging for VPC DNS."
  default     = true
}

variable "firewall_enable_logging" {
  type        = bool
  description = "Toggle firewall logging for VPC Firewalls."
  default     = true
}

variable "dns_enable_inbound_forwarding" {
  type        = bool
  description = "Toggle inbound query forwarding for VPC DNS."
  default     = true
}

variable "windows_activation_enabled" {
  type        = bool
  description = "Enable Windows license activation for Windows workloads."
  default     = false
}

variable "nat_enabled" {
  type        = bool
  description = "Toggle creation of NAT cloud router."
  default     = false
}

variable "nat_bgp_asn" {
  type        = number
  description = "BGP ASN for first NAT cloud routes."
  default     = 64514
}

variable "nat_num_addresses_region1" {
  type        = number
  description = "Number of external IPs to reserve for first Cloud NAT."
  default     = 2
}

variable "nat_num_addresses_region2" {
  type        = number
  description = "Number of external IPs to reserve for second Cloud NAT."
  default     = 2
}

variable "nat_num_addresses" {
  type        = number
  description = "Number of external IPs to reserve for Cloud NAT."
  default     = 2
}

variable "optional_fw_rules_enabled" {
  type        = bool
  description = "Toggle creation of optional firewall rules: IAP SSH, IAP RDP and Internal & Global load balancing health check and load balancing IP ranges."
  default     = false
}

variable "parent_folder" {
  description = "Optional - for an organization with existing projects or for development/validation. It will place all the example foundation resources under the provided folder instead of the root organization. The value is the numeric folder ID. The folder must already exist. Must be the same value used in previous step."
  type        = string
  default     = ""
}

variable "folder_prefix" {
  description = "Name prefix to use for folders created. Should be the same in all steps."
  type        = string
  default     = "fldr"
}

variable "enable_hub_and_spoke" {
  description = "Enable Hub-and-Spoke architecture."
  type        = bool
  default     = false
}

variable "enable_partner_interconnect" {
  description = "Enable Partner Interconnect in the environment."
  type        = bool
  default     = false
}

variable "enable_hub_and_spoke_transitivity" {
  description = "Enable transitivity via gateway VMs on Hub-and-Spoke architecture."
  type        = bool
  default     = false
}

variable "subnet_config_base" {
  description = "subnet configuration for base vpc"
  type = list(object({
    name   = string
    ip     = string
    region = string
    secondary_ranges = list(object({
      range_name    = string
      ip_cidr_range = string
    }))
  }))
  default = []
}

variable "subnet_config_restricted" {
  description = "subnet configuration for restricted vpc "
  type = list(object({
    name   = string
    ip     = string
    region = string
    secondary_ranges = list(object({
      range_name    = string
      ip_cidr_range = string
    }))
  }))
  default = []
}

variable "rules" {
  description = "List of custom rule definitions"
  type = list(object({
    name                    = string
    description             = string
    direction               = string
    priority                = number
    ranges                  = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
    log_config = object({
      metadata = string
    })
  }))
  default = []
}
