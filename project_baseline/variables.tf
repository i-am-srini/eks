variable "org_id" {
  description = "The organization id for the associated services"
  type        = string
}

variable "folder_id" {
  description = "The folder id where project will be created"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associated this project with"
  type        = string
}

variable "project_name" {
  description = "The name of the GCP project. Max 19 characters."
  type        = string
}

variable "project_prefix" {
  description = "The prefix of the GCP project. Max 19 characters."
  type        = string
  default     = ""
}

variable "billing_code" {
  description = "The code that's used to provide chargeback information"
  type        = string
}

variable "primary_contact" {
  description = "The primary email contact for the project"
  type        = string
  default     = ""
}

variable "secondary_contact" {
  description = "The secondary email contact for the project"
  type        = string
  default     = ""
}

variable "activate_apis" {
  description = "The api to activate for the GCP project"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "The environment the single project belongs to"
  type        = string
}

variable "vpc_type" {
  description = "The type of VPC to attach the project to. Possible options are base or restricted."
  type        = string
  default     = ""
}

variable "vpc_service_control_attach_enabled" {
  description = "Whether the project will be attached to a VPC Service Control Perimeter"
  type        = bool
  default     = false
}

variable "vpc_service_control_perimeter_name" {
  description = "The name of a VPC Service Control Perimeter to add the created project to"
  type        = string
  default     = null
}

variable "budget_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded"
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "budget_amount" {
  description = "The amount to use as the budget"
  type        = number
  default     = 1000
}

variable "enable_hub_and_spoke" {
  description = "Enable Hub-and-Spoke architecture."
  type        = bool
  default     = false
}

variable "sa_roles" {
  description = "A list of roles to give the Service Account for the project (defaults to none)"
  type        = list(string)
  default     = []
}

variable "enable_cloudbuild_deploy" {
  description = "Enable infra deployment using Cloud Build"
  type        = bool
  default     = false
}

variable "cloudbuild_sa" {
  description = "The Cloud Build SA used for deploying infrastructure in this project. It will impersonate the new default SA created"
  type        = string
  default     = ""
}

variable "labels" {
  type        = map(string)
  description = "Labels to be attached to the buckets"
  default     = {}
}

#################################
# Pub Sub Variables
################################

variable "budget_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}`"
  type        = string
  default     = ""
}

################
# logging
################
variable "sinks" {
  description = "logging sinks settings"
  type = map(object({
    name                   = string
    destination            = string
    filter                 = string
    unique_writer_identity = bool
  }))
  default = {
    "my-test" = {
      name                   = "my-test"
      destination            = "storage.googleapis.com/testrinat"
      filter                 = "resource.type = gcs.instance AND severity >=WARNING"
      unique_writer_identity = true
    }
  }
}

variable "monitoring_alerts" {
  type = map(object({
    display_name           = string
    combiner               = string
    display_name_condition = string
    filter                 = string
    duration               = string
    comparison             = string
    alignment_period       = string
    per_series_aligner     = string
  }))
  default = {
    test = {
      display_name           = "test"
      combiner               = "OR"
      display_name_condition = "new test condition"
      filter                 = "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\""
      duration               = "60s"
      comparison             = "COMPARISON_GT"
      alignment_period       = "60s"
      per_series_aligner     = "ALIGN_RATE"
    }
  }
}
################
## Fortress
################

variable "enable_fortress" {
  description = "Enable Fortress Hub|Spoke Delpoyment"
  type        = bool
  default     = false
}

variable "fortress_hub_project_id" {
  type        = string
  description = "Fortress Hub project id. (Required if Spoke Deployment)"
  default     = ""
}

variable "fortress_deployment" {
  type        = string
  description = "Hub|Spoke"
  default     = "spoke"
  validation {
    condition     = contains(["spoke", "hub"], var.fortress_deployment)
    error_message = "Valid values for var: deployment are hub|spoke."
  }
}
################
## Firestore
################
variable "enable_firestore" {
  description = "Enables Datastore using the App Engine Resource"
  type        = bool
  default     = true
}
