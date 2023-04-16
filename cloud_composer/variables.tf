variable "region" {
  description = "Region where the Cloud Composer Environment is created."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zone where the Cloud Composer nodes are created."
  type        = string
  default     = "us-central1-f"
}

variable "project_id" {
  type        = string
  description = "The resource labels (a map of key/value pairs) to be applied to the Cloud Composer."
}

variable "network" {
  description = "The network id"
  type        = string
}

variable "subnetwork_region" {
  type        = string
  description = "The subnetwork region of the shared VPC's host (for shared vpc support)"
  default     = ""
}

variable "cloud_composer_subnet_self_link" {
  type        = string
  description = "Self link of existing composer Subnet (Optional)"
  default     = ""
}

variable "subnet_name" {
  type        = string
  description = "The name of the existing GCP subnetwork for composer services"
}

variable "network_project_id" {
  type        = string
  description = "The project id of the existing GCP subnetwork for composer services"
}

variable "composer_config" {
  type = map(object({
    composer_env_name                = string
    node_count                       = number
    machine_type                     = string
    use_ip_aliases                   = bool
    pod_ip_allocation_range_name     = string
    service_ip_allocation_range_name = string
    labels                           = map(string)
    disk_size                        = string
    oauth_scopes                     = set(string)
    tags                             = set(string)
    airflow_config_overrides         = map(string)
    env_variables                    = map(string)
    image_version                    = string
    pypi_packages                    = map(string)
    python_version                   = string
    cloud_sql_ipv4_cidr              = string
    web_server_ipv4_cidr             = string
    master_ipv4_cidr                 = string
    enable_private_endpoint          = bool
    kms_key_name                     = string
  }))
  default = {
    "object" = {
      composer_env_name                = "mycomposer-newtest"
      node_count                       = 3
      machine_type                     = "n1-standard-8"
      use_ip_aliases                   = true
      pod_ip_allocation_range_name     = null
      service_ip_allocation_range_name = null
      labels                           = {}
      disk_size                        = "100"
      oauth_scopes                     = ["https://www.googleapis.com/auth/cloud-platform"]
      tags                             = []
      airflow_config_overrides         = {}
      env_variables                    = {}
      image_version                    = null
      pypi_packages                    = {}
      python_version                   = 3
      cloud_sql_ipv4_cidr              = null
      web_server_ipv4_cidr             = null
      master_ipv4_cidr                 = null
      enable_private_endpoint          = true
      kms_key_name                     = null
  } }
  description = "The cloud composer configuration"
}

#################################
# KMS Variables
################################

variable "enable_cmek" {
  description = "Enable Customer Managed Encryption Key"
  type        = bool
  default     = true
}

variable "use_existing_keyring" {
  description = "If you want to use an existing keyring and don't create a new one -> true"
  type        = bool
  default     = false
}

variable "keyring" {
  description = "Name to be used for KMS Keyring for CMEK"
  type        = string
  default     = "keyring-cloud-composer"
}

variable "key_rotation_period" {
  description = "Rotation period in seconds to be used for KMS Key"
  type        = string
  default     = "7776000s"
}

variable "prevent_destroy" {
  type        = bool
  description = "Prevent bucket key destroy on KMS"
  default     = true
}

#################################
# service account Variables
################################

variable "service-account_config" {
  type = map(string)
  default = {
    account_id   = "newtest-cloud-composer"
    display_name = "cloud-composer"
    description  = "service account for cloud-composer"
  }
  description = "The service account configuration"
}
