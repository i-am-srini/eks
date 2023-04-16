variable "project_id" {
  type        = string
  description = "The ID of the project in which the resource belongs."
}

variable "healthcare_sa" {
  type        = string
  description = "The healthcare service account."
  default     = ""
}

variable "healthcare_name" {
  type        = string
  description = "The resource name for the Dataset."
}

variable "healthcare_location" {
  type        = string
  description = "The location for the Dataset."
}

variable "iam_members" {
  type = list(object({
    role   = string
    member = string
  }))
  description = "Updates the IAM policy to grant a role to a new member. Other members for the role for the dataset are preserved."
  default     = []
}

# TODO(https://github.com/hashicorp/terraform/issues/19898): Convert these
# to list of objects once optional variables are supported.

# All stores are list of objects supporting the following fields:
#  name: string (required)
#  dataset: string (required)
#  labels: map(string) (optional)
#  iam_members: list of objects (optional)
#    role: string (required)
#    member: string (required)

# Extra fields for dicom_stores:
#  notification_config: object (optional)
#    pubsub_topic: string (required)
variable "dicom_stores" {
  type        = any
  description = "Datastore that conforms to the DICOM (https://www.dicomstandard.org/about/) standard for Healthcare information exchange."
  default     = []
}

# Extra fields for fhir_stores:
#  version: string (required)
#  enable_update_create: bool (optional)
#  disable_referential_integrity: bool (optional)
#  disable_resource_versioning: bool (optional)
#  enable_history_import: bool (optional)
#  notification_config: object (optional)
#    pubsub_topic: string (required)
#  stream_configs: list(object) (optional)
#    See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/healthcare_fhir_store#stream_configs for attributes
variable "fhir_stores" {
  type        = any
  description = "Datastore that conforms to the FHIR standard for Healthcare information exchange."
  default     = []
}

# Extra fields for dicom_stores:
#  notification_configs: list(object) (optional)
#    pubsub_topic: string (required)
#  parser_config: object (optional)
#    See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/healthcare_hl7_v2_store#parser_config for attributes
variable "hl7_v2_stores" {
  type        = any
  description = "Datastore that conforms to the HL7 V2 (https://www.hl7.org/hl7V2/STU3/) standard for Healthcare information exchange."
  default     = []
}

# Extra fields for consent_stores:
#  enable_consent_create_on_update: bool (optional)
#  default_consent_ttl: string (optional)
variable "consent_stores" {
  type        = any
  description = "Datastore that contain all information related to the configuration and operation of the Consent Management API (https://cloud.google.com/healthcare/docs/how-tos/consent-managing)."
  default     = []
}

#################################
# Pub Sub Variables
################################

variable "create_pub_sub" {
  description = "Create BigQuery, if false topic_name required"
  type        = bool
  default     = true
}

variable "topic_name" {
  type        = string
  description = "The ID of the bigquery dataset."
  default     = ""
}

#################################
# Big Query Variables
################################

variable "create_big_query" {
  description = "Create BigQuery, if false dataset_id and table_id required"
  type        = bool
  default     = true
}

variable "dataset_id" {
  type        = string
  description = "The ID of the bigquery dataset."
  default     = ""
}

variable "table_id" {
  type        = string
  description = "The ID of the bigquery table."
  default     = ""
}

variable "dataset_name" {
  description = "The dataset name."
  type        = string
  default     = ""
}

variable "tables" {
  description = "A list of objects which include table_id, schema, clustering, time_partitioning, range_partitioning, expiration_time and labels."
  default     = []
  type = list(object({
    table_id   = string,
    schema     = string,
    clustering = list(string),
    time_partitioning = object({
      expiration_ms            = string,
      field                    = string,
      type                     = string,
      require_partition_filter = bool,
    }),
    range_partitioning = object({
      field = string,
      range = object({
        start    = string,
        end      = string,
        interval = string,
      }),
    }),
    expiration_time = string,
    labels          = map(string),
  }))
}

#################################
# KMS Variables
################################

variable "enable_cmek" {
  description = "Enable Customer Managed Encryption Key"
  type        = bool
  default     = false
}
