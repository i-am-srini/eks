variable "env" {
  description = "The environment to prepare (ex. development)"
  type        = string
}

variable "parent_id" {
  description = "The parent folder or org for environments"
  type        = string
}

variable "org_id" {
  description = "The organization id for the associated services"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
  type        = string
}

variable "billing_code" {
  description = "billing_code"
  type        = string
  default     = "env"
}

variable "monitoring_workspace_users" {
  description = "Google Workspace or Cloud Identity group that have access to Monitoring Workspaces."
  type        = string
}

variable "base_network_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the base networks project"
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "base_network_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the base networks project"
  type        = string
  default     = null
}

variable "base_network_project_budget_amount" {
  description = "The amount to use as the budget for the base networks project"
  type        = number
  default     = 1000
}

variable "restricted_network_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the restricted networks project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "restricted_network_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the restricted networks project"
  type        = string
  default     = null
}

variable "restricted_network_project_budget_amount" {
  description = "The amount to use as the budget for the restricted networks project."
  type        = number
  default     = 1000
}

variable "monitoring_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the monitoring project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "monitoring_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the monitoring project."
  type        = string
  default     = null
}

variable "monitoring_project_budget_amount" {
  description = "The amount to use as the budget for the monitoring project."
  type        = number
  default     = 1000
}

variable "secret_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the secrets project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "secret_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the secrets project."
  type        = string
  default     = null
}

variable "secret_project_budget_amount" {
  description = "The amount to use as the budget for the secrets project."
  type        = number
  default     = 1000
}

variable "folder_prefix" {
  description = "Name prefix to use for folders created."
  type        = string
  default     = "fldr"
}

# variable "domains_to_allow" {
#   description = "The list of domains to allow users from in IAM. Used by Domain Restricted Sharing Organization Policy. Must include the domain of the organization you are deploying the foundation. To add other domains you must also grant access to these domains to the terraform service account used in the deploy."
#   type        = list(string)
# }

variable "primary_contact" {
  description = "primary_contact"
  type        = string
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
  description = "Fortress Hub project id. (Required)"
  default     = ""
}
