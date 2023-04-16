variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "compute_service_account" {
  description = "The Google service account ID."
  type        = string
  default     = ""
}

variable "instance_prefix" {
  description = "Name prefix for the instance template"
  type        = string
  default     = "instance-template-"
}

variable "region" {
  description = "Region where the instance template should be created."
  type        = string
  default     = "us-east1"
}

variable "can_ip_forward" {
  description = "Enable IP forwarding, for NAT instances for example"
  type        = string
  default     = "false"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = string
  default     = "100"
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  type        = string
  default     = "pd-standard"
}

variable "machine_type" {
  description = "Machine type to create, e.g. n1-standard-1"
  type        = string
  default     = "n1-standard-1"
}

variable "roles_list" {
  description = "roles list for the service account"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Network tags, provided as a list"
  type        = list(string)
}

variable "network" {
  description = "The name or self_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks."
  type        = string
  default     = ""
}

variable "num_instances" {
  description = "Number of instances to create."
  type        = string
  default     = "1"
}

variable "source_image" {
  description = "Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
  type        = string
  default     = ""
}

variable "startup_script" {
  description = "User startup script to run when instances spin up"
  type        = string
  default     = ""
}

variable "subnetwork" {
  description = "The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
  type        = string
  default     = ""
}

variable "metadata" {
  description = "Metadata provided as a map"
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Labels provided as a map"
  type        = map(string)
  default     = {}
}

variable "sa_prefix" {
  description = "Name prefix for the service account"
  type        = string
  default     = "default"
}

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet. The networking tier used for configuring this instance. This field can take the following values: PREMIUM or STANDARD."
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}

variable "zone" {
  type        = string
  description = "Zone where the instances should be created. If not specified, instances will be spread across available zones in the region."
  default     = null
}

variable "terraform_service_account" {
  description = "Service account email of the account to impersonate to run Terraform."
  type        = string
}

/******************************************
  KMS
*****************************************/

variable "create_key" {
  description = "If you want to use an create a key"
  type        = bool
  default     = true
}

variable "disk_encryption_key" {
  description = "The self link of the encryption key that is stored in Google Cloud KMS to use to encrypt all the disks on this instance"
  type        = string
  default     = ""
}

variable "use_existing_keyring" {
  description = "If you want to use an existing keyring and don't create a new one -> true"
  type        = bool
  default     = false
}

variable "key_name" {
  description = "Name to be used for KMS Key for CMEK"
  type        = string
  default     = "key"
}

variable "keyring_name" {
  description = "Name to be used for KMS Keyring for CMEK"
  type        = string
  default     = "keyring-compute"
}

variable "key_rotation_period" {
  description = "Rotation period in seconds to be used for KMS Key"
  type        = string
  default     = "7776000s"
}

variable "prevent_destroy" {
  type        = string
  description = "Prevent bucket key destroy on KMS"
  default     = "true"
}
