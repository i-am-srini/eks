variable "project_id" {
  type        = string
  description = "Bucket project id."
}

variable "names" {
  type        = list(string)
  description = "Bucket name suffixes."
  default     = []
}

variable "prefix" {
  type        = string
  description = "Prefix used to generate the bucket name"
  default     = ""
}

variable "bucket_location" {
  type        = string
  description = "Bucket location"
}

variable "storage_class" {
  type        = string
  description = "Storage class."
  default     = "MULTI_REGIONAL"
}

variable "labels" {
  type        = map(string)
  description = "Labels to be attached to the buckets"
  default     = {}
}

variable "gcs_admin_group_id" {
  description = "The gcs admin group id that will be connected to the buckets"
  type        = string
  default     = ""
}

variable "gcs_write_group_id" {
  description = "The gcs write group id that will be connected to the buckets"
  type        = string
  default     = ""
}

variable "prevent_destroy" {
  type        = bool
  description = "Prevent bucket key destroy on KMS"
  default     = true
}

variable "versioning" {
  type        = bool
  description = "Versioning of the buckets"
  default     = true
}

variable "lifecycle_rules" {
  type = set(object({
    action    = map(string)
    condition = map(string)
  }))
  description = "List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches_storage_class should be a comma delimited string."
  default     = [({ condition = { age = 3 }, action = { type = "Delete" } })]
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

variable "keyring_name" {
  description = "Name to be used for KMS Keyring for CMEK"
  type        = string
  default     = "keyring-gcs_buckets"
}

variable "key_rotation_period" {
  description = "Rotation period in seconds to be used for KMS Key"
  type        = string
  default     = "7776000s"
}
