variable "project_id" {
  description = "The name of the project id"
  type        = string
}

variable "display_name" {
  description = "The display name of the bigtable instance"
  type        = string
  default     = ""
}

variable "name" {
  description = "The name of the cluster"
  type        = string
}

variable "labels" {
  description = "Define labels for an instance"
  type        = map(string)
  default     = {}
}

variable "cluster_configuration" {
  description = "Bigtable cluster configuration"
  type = object({
    cluster_id   = string
    zone         = string
    num_nodes    = number
    storage_type = string
  })
  default = {
    cluster_id   = ""
    zone         = ""
    num_nodes    = 1
    storage_type = ""
  }
}

variable "table_name" {
  description = "The name of the table"
  type        = string
  default     = ""
}

variable "family" {
  description = "The name of the column family"
  type        = string
  default     = ""
}

########################################
## Bigtable App Profile - Singlecluster
########################################

variable "app_profile_id" {
  description = "The name of App Profile ID"
  type        = string
}

variable "allow_transactional_writes" {
  description = "If true, CheckAndMutateRow and ReadModifyWriteRow requests are allowed by app profile"
  type        = bool
  default     = true
}

variable "duration" {
  description = "GC policy that applies to all cells older than the given age"
  type        = string
}

######################
## Bigtable IAM
######################

variable "bigtable_member" {
  type        = string
  description = "Member to add to auto-generated service account to access bigtable (Optional)"
}

variable "create_bigtable_group" {
  type        = bool
  description = "Create a bigtable group (Optional)"
}

variable "bigtable_group_owners" {
  type        = list(string)
  description = "The bigtable group owners (Optional)"
}

variable "bigtable_group_id" {
  type        = string
  description = "The bigtable group id (Optional)"
}

######################
## Bigtable KMS
######################

variable "enable_cmek" {
  description = "Enable Customer Managed Encryption Key"
  type        = bool
  default     = false
}

variable "use_existing_keyring" {
  description = "If you want to use an existing keyring and don't create a new one -> true"
  type        = bool
  default     = false
}

variable "keyring_name" {
  description = "Keyring name."
  type        = string
  default     = "bigtable-keyring"
}

variable "location" {
  description = "Location for the keyring."
  type        = string
  default     = ""
}
