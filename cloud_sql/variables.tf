variable "database_type" {
  type        = string
  description = "Cloud SQL database - postgres / mysql / mssql"
  validation {
    condition     = contains(["postgres", "mysql", "mssql"], var.database_type)
    error_message = "Sorry, the valid input for var database_type are postgres or mysql or mssql."
  }
}

variable "admin_user" {
  #sensitive = true
  type        = string
  description = "The admin username"
  default     = "admin"
}

variable "root_password" {
  #sensitive = true
  type        = string
  description = "The Root password"
  default     = ""
}

variable "sql_instance_prefix" {
  type        = string
  description = "The instance name prefix, random string is added as suffix"
}

variable "database_name" {
  type        = string
  description = "The database name"
}

variable "database_version" {
  type        = string
  description = "The database version"
}

variable "instance_availability_type" {
  description = "The availability type for the master instance.This is only used to set up high availability for the MSSQL instance. Can be either `ZONAL` or `REGIONAL`."
  type        = string
}

variable "region" {
  type        = string
  description = "The database/Bastion instance region"
}

variable "database_users" {
  type = list(object({
    name     = string
    password = string
    host     = string
  }))
  description = "Additional Database Users"
  default     = []
}

variable "database_flags" {
  description = "The database flags for the master instance. See [more details](https://cloud.google.com/sql/docs/sqlserver/flags)"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "zone" {
  type        = string
  description = "The database/bastion instance zone"
}

variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "replica_zones" {
  type = object({
    zone1 = string
    zone2 = string
  })
  description = "The GCP Zones"
}

variable "authorized_networks" {
  type        = list(map(string))
  description = "CIDR Ranges of Secondary IP ranges for all GKE Cluster Subnets"
}

variable "additional_databases" {
  type = list(object({
    name      = string
    charset   = string
    collation = string
  }))
  description = "Additional Databases"
  default     = []
}

variable "bastion_subnet" {
  type        = string
  description = "The name of the GCP subnetwork for bastion services"
}

variable "bastion_instance_name" {
  type        = string
  description = "The name of the bastion instance"
}

variable "shared_vpc_project_id" {
  type        = string
  description = "Shared Network Project ID"
}

variable "shared_vpc_name" {
  type        = string
  description = "The name of the bastion VPC in the Shared Network Project"
}

variable "bastion_service_account_name" {
  type        = string
  description = "The service account to be created for the bastion."
}

variable "sql_group_id" {
  type        = string
  description = "The SQL group id"
}

variable "sql_group_owners" {
  type        = list(string)
  description = "The SQL group owners"
  default     = []
}

variable "sql_group_members" {
  type        = list(string)
  description = "The SQL group members"
  default     = []
}

variable "env" {
  type        = string
  description = "The mysql database env, for deletion protection, true for prod environments and false for test environments"
  default     = "prod"
}

variable "tier" {
  type        = string
  description = "The tier for the master instance."
  default     = "db-custom-2-13312"
}

variable "backup_configuration" {
  type = object({
    enabled                        = bool
    start_time                     = string
    location                       = string
    point_in_time_recovery_enabled = bool
    binary_log_enabled             = bool
    transaction_log_retention_days = string
    retained_backups               = number
    retention_unit                 = string
  })
  description = "The backup_configuration settings subblock for the database setings"
  default = {
    enabled                        = true
    start_time                     = "20:55"
    location                       = null
    point_in_time_recovery_enabled = false
    binary_log_enabled             = true
    transaction_log_retention_days = null
    retained_backups               = null
    retention_unit                 = null
  }
}
