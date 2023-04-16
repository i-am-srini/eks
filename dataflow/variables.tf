variable "project_id" {
  type        = string
  description = "The project ID to deploy to"
}

variable "region" {
  type        = string
  description = "The region in which the bucket will be deployed"
}

variable "zone" {
  type        = string
  description = "The zone in which the dataflow job will be deployed"
}

variable "df_job_name" {
  type        = string
  description = "The name of the dataflow job"
}

variable "template_gcs_path" {
  type        = string
  description = "A writeable location on GCS for the Dataflow job to dump its temporary data."
}

variable "create_bucket" {
  description = "Create dataflow GCS bucket."
  type        = bool
  default     = true
}

variable "dataflow_bucket" {
  type        = string
  description = "Bucket name prefix."
  default     = "dataflow-bucket"
}

variable "parameters" {
  type        = map(any)
  description = "Key/Value pairs to be passed to the Dataflow job (as used in the template)."
  default     = {}
}

variable "additional_experiments" {
  type        = list
  description = "List of experiments to enable."
  default     = []
}

variable "enable_streaming_engine" {
  type        = bool
  description = "Enable/Disable Streaming Engine for Dataflow job."
  default     = false
}

variable "labels" {
  type        = map(string)
  description = "User labels to be specified for the job."
  default     = {}
}

#################################
# Network Variables
################################

variable "network_project_id" {
  type        = string
  description = "Network project ID"
}

variable "vpc_name" {
  type        = string
  description = "VPC Network name"
}

variable "subnet_name" {
  type        = string
  description = "Subnetwork name"
}

#################################
# KMS Variables
################################

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
  default     = "dataflow-keyring"
}
