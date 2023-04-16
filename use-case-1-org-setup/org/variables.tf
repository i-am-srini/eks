/******************************************
  General Settings
*****************************************/
variable "org_id" {
  description = "The organization id for the associated services"
  type        = string
}

variable "domain" {
  description = "The organization domain name"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
  type        = string
}

variable "terraform_service_account" {
  description = "Service account email of the account to impersonate to run Terraform."
  type        = string
}

variable "default_region" {
  description = "Default region for BigQuery resources."
  type        = string
  default     = "us-east1"
}

variable "skip_gcloud_download" {
  description = "Whether to skip downloading gcloud (assumes gcloud is already available outside the module. If set to true you, must ensure that Gcloud Alpha module is installed.)"
  type        = bool
  default     = true
}

variable "parent_folder" {
  description = "Optional - for an organization with existing projects or for development/validation. It will place all the example foundation resources under the provided folder instead of the root organization. The value is the numeric folder ID. The folder must already exist. Must be the same value used in previous step."
  type        = string
  default     = ""
}

variable "create_acm_policy" {
  description = "Optional - for an organization that doesn't already have google access context manager access policy."
  type        = bool
  default     = false
}
/******************************************
  Networking Settings
*****************************************/
variable "enable_hub_and_spoke" {
  description = "Enable Hub-and-Spoke architecture."
  type        = bool
  default     = true
}

/******************************************
  Groups Settings
*****************************************/
variable "groups" {
  description = "Map of groups to create or assign roles to"
  type = map(object({
    id           = string
    roles        = list(string)
    display_name = string
    description  = string
    create_group = bool
  }))
  default = {}
}

variable "group_owners" {
  description = "Owners of all the groups created in this module. Each entry is the ID of an entity. For Google-managed entities, the ID must be the email address of an existing group, user or service account"
  type        = list(string)
  default     = []
}

variable "billing_data_users" {
  description = "Google Workspace or Cloud Identity group that have access to billing data set. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account."
  type        = string
  default     = ""
}

variable "audit_data_users" {
  description = "Google Workspace or Cloud Identity group that have access to audit logs. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account."
  type        = string
  default     = ""
}

variable "scc_admins" {
  description = "Google Workspace or Cloud Identity group that have access to the org level security and command center as admin. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account."
  type        = string
  default     = ""
}

variable "scc_analysts" {
  description = "Google Workspace or Cloud Identity group that have access to the org level security and command center as analysts. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account."
  type        = string
  default     = ""
}

variable "scc_auditors" {
  description = "Google Workspace or Cloud Identity group that have read-only access to the org level security and command center. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account."
  type        = string
  default     = ""
}

variable "secret_admin" {
  description = "Google Workspace or Cloud Identity group that have access to the org level secrets as admin. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account."
  type        = string
  default     = ""
}

variable "secret_analysts" {
  description = "Google Workspace or Cloud Identity group that have access to the org level secrets as analysts. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account."
  type        = string
  default     = ""
}

variable "gcs_admin" {
  description = "Google Workspace or Cloud Identity group that have admin access to buckets. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account."
  type        = string
  default     = ""
}

variable "gcs_write" {
  description = "Google Workspace or Cloud Identity group that have write access to buckets. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account."
  type        = string
  default     = ""
}

/******************************************
  Security Notification Settings
*****************************************/
variable "scc_notification_name" {
  description = "Name of the Security Command Center Notification. It must be unique in the organization. Run `gcloud scc notifications describe <scc_notification_name> --organization=org_id` to check if it already exists."
  type        = string
}

variable "scc_notification_filter" {
  description = "Filter used to create the Security Command Center Notification, you can see more details on how to create filters in https://cloud.google.com/security-command-center/docs/how-to-api-filter-notifications#create-filter"
  type        = string
  default     = "state=\\\"ACTIVE\\\""
}

# variable "create_asset_feed_public_cloud_storage" {
#   description = "create_asset_feed_public_cloud_storage"
#   type        = bool
#   default     = true
# }

/******************************************
  Logging Settings
*****************************************/
variable "audit_logs_table_expiration_days" {
  description = "Period before tables expire for all audit logs in milliseconds. Default is 30 days."
  type        = number
  default     = 30
}

variable "data_access_logs_enabled" {
  description = "Enable Data Access logs of types DATA_READ, DATA_WRITE and ADMIN_READ for all GCP services. Enabling Data Access logs might result in your organization being charged for the additional logs usage. See https://cloud.google.com/logging/docs/audit#data-access"
  type        = bool
  default     = true
}

variable "log_export_storage_location" {
  description = "The location of the storage bucket used to export logs."
  type        = string
  default     = "US"
}

variable "log_export_storage_versioning" {
  description = "(Optional) Toggles bucket versioning, ability to retain a non-current object version when the live object version gets replaced or deleted."
  type        = bool
  default     = false
}

variable "log_export_storage_retention_policy" {
  description = "Configuration of the bucket's data retention policy for how long objects in the bucket should be retained."
  type = object({
    is_locked             = bool
    retention_period_days = number
  })
  default = null
}

/******************************************
  Billing and Budget Settings
*****************************************/
variable "dns_hub_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the DNS hub project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "dns_hub_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the DNS hub project."
  type        = string
  default     = null
}

variable "dns_hub_project_budget_amount" {
  description = "The amount to use as the budget for the DNS hub project."
  type        = number
  default     = 1000
}

variable "base_net_hub_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the base net hub project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "base_net_hub_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the base net hub project."
  type        = string
  default     = null
}

variable "base_net_hub_project_budget_amount" {
  description = "The amount to use as the budget for the base net hub project."
  type        = number
  default     = 1000
}

variable "restricted_net_hub_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the restricted net hub project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "restricted_net_hub_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the restricted net hub project."
  type        = string
  default     = null
}

variable "restricted_net_hub_project_budget_amount" {
  description = "The amount to use as the budget for the restricted net hub project."
  type        = number
  default     = 1000
}

variable "interconnect_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the Dedicated Interconnect project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "interconnect_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the Dedicated Interconnect project."
  type        = string
  default     = null
}

variable "interconnect_project_budget_amount" {
  description = "The amount to use as the budget for the Dedicated Interconnect project."
  type        = number
  default     = 1000
}

variable "org_secrets_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the org secrets project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "org_secrets_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the org secrets project."
  type        = string
  default     = null
}

variable "org_secrets_project_budget_amount" {
  description = "The amount to use as the budget for the org secrets project."
  type        = number
  default     = 1000
}

variable "org_billing_logs_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the org billing logs project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "org_billing_logs_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the org billing logs project."
  type        = string
  default     = null
}

variable "org_billing_logs_project_budget_amount" {
  description = "The amount to use as the budget for the org billing logs project."
  type        = number
  default     = 1000
}

variable "org_audit_logs_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the org audit logs project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "org_audit_logs_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the org audit logs project."
  type        = string
  default     = null
}

variable "org_audit_logs_project_budget_amount" {
  description = "The amount to use as the budget for the org audit logs project."
  type        = number
  default     = 1000
}

variable "scc_notifications_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the SCC notifications project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "scc_notifications_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the SCC notifications project."
  type        = string
  default     = null
}

variable "scc_notifications_project_budget_amount" {
  description = "The amount to use as the budget for the SCC notifications project."
  type        = number
  default     = 1000
}

/******************************************
  Prefix
*****************************************/
variable "folder_prefix" {
  description = "Name prefix to use for folders created. Should be the same in all steps."
  type        = string
  default     = "fldr"
}

#################################
# Pub Sub Variables
################################

variable "create_pub_sub" {
  description = "Create PubSub topic, if false topic_name required"
  type        = bool
  default     = true
}

#################################
# KMS Variables
################################

variable "enable_cmek_pubsub" {
  description = "Enable Customer Managed Encryption Key"
  type        = bool
  default     = false
}

variable "labels" {
  type        = map(string)
  description = "The labels associated with this dataset."
  default     = {}
}
