variable "org_id" {
  description = "GCP Organization ID"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate projects with."
  type        = string
}

# variable "group_org_admins" {
#   description = "Google Group for GCP Organization Administrators"
#   type        = string
# }

# variable "group_billing_admins" {
#   description = "Google Group for GCP Billing Administrators"
#   type        = string
# }

# variable "org_project_creators" {
#   description = "Additional list of members to have project creator role across the organization. Prefix of group: user: or serviceAccount: is required."
#   type        = list(string)
#   default     = []
# }

variable "primary_region" {
  type        = string
  description = "Primary GCP region"
  default     = "us-east1"
}

variable "scc_notification_name" {
  description = "Name of SCC Notification"
  type        = string
}

variable "domain" {
  type        = string
  description = "The DNS name of peering managed zone, for instance 'example.com.'"
}

variable "secondary_region" {
  type        = string
  description = "Primary GCP secondary_region"
  default     = "us-west1"
}

variable "billing_code" {
  description = "Billing Code on projects"
  type        = string
}

variable "monitoring_workspace_users" {
  description = "Gsuite or Cloud Identity group that have access to Monitoring Workspaces."
  type        = string
}

variable "alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded"
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "budget_amount" {
  description = "The amount to use as the budget"
  type        = number
  default     = 1000
}

variable "contacts" {
  description = "Primary and secondary contact"
  type        = list(string)
  default     = ["", ""]
}

variable "alert_pubsub_topic" {
  description = "Primary and secondary contact"
  type        = string
  default     = null
}

variable "terraform_service_account" {
  description = "Service account email of the account to impersonate to run Terraform."
  type        = string
}

variable "primary_contact" {
  description = "primary_contact"
  type        = string
}

variable "target_name_server_addresses" {
  description = "List of IPv4 address of target name servers for the forwarding zone configuration. See https://cloud.google.com/dns/docs/overview#dns-forwarding-zones for details on target name servers in the context of Cloud DNS forwarding zones."
  type        = list(string)
}
