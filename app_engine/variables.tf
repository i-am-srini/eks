variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "location" {
  type        = string
  description = "Location for app-engine and bucket"
}

variable "database_type" {
  type        = string
  description = "Database Type for App Engine"
  default     = "CLOUD_FIRESTORE"
}

variable "initialize_app" {
  type        = bool
  description = "Create App Engine Version"
  default     = true
}

variable "create_app" {
  type        = bool
  description = "Create App Engine Version"
  default     = true
}

variable "version_id" {
  type        = string
  description = "the version id"
  default     = "v1"
}

variable "service" {
  type        = string
  description = "the name service"
  default     = "default"
}

variable "runtime" {
  type        = string
  description = "the runtime of the application"
  default     = ""
}

variable "entrypoint" {
  type        = string
  description = "the entrypoint of the application"
  default     = ""
}

variable "env_variables" {
  type        = map
  description = "the environment variables of the application"
  default     = {}
}

variable "basic_scaling" {
  type = object({
    max_instances = number
  })
  description = "the basic scaling of the application"
  default     = null
}

###############
## GCS
###############

variable "source_code_bucket" {
  type        = string
  description = "The bucket name of the source code of the application"
  default     = "ae-files"
}

variable "labels" {
  type        = map(string)
  description = "sorce code labels to be attached to the buckets"
  default     = {}
}

variable "enable_cmek" {
  type        = bool
  description = "Create App Engine Version"
  default     = false
}
