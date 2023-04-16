locals {
  environment  = "shared"
  billing_code = "org"
}

module "org_audit_logs" {
  source                      = "../../modules/project_baseline"
  primary_contact             = local.audit_data_users
  environment                 = local.environment
  project_name                = "logging"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  billing_code                = local.billing_code
  folder_id                   = google_folder.common.id
  activate_apis               = ["logging.googleapis.com", "bigquery.googleapis.com", "billingbudgets.googleapis.com"]
  budget_alert_pubsub_topic   = var.org_audit_logs_project_alert_pubsub_topic
  budget_alert_spent_percents = var.org_audit_logs_project_alert_spent_percents
  budget_amount               = var.org_audit_logs_project_budget_amount
}

module "org_billing_logs" {
  source                      = "../../modules/project_baseline"
  primary_contact             = local.billing_data_users
  environment                 = local.environment
  project_name                = "billing-logs"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  billing_code                = local.billing_code
  folder_id                   = google_folder.common.id
  activate_apis               = ["logging.googleapis.com", "bigquery.googleapis.com", "billingbudgets.googleapis.com"]
  budget_alert_pubsub_topic   = var.org_billing_logs_project_alert_pubsub_topic
  budget_alert_spent_percents = var.org_billing_logs_project_alert_spent_percents
  budget_amount               = var.org_billing_logs_project_budget_amount
  labels                      = { "project_purpose" : "billing_budget" }
}

module "pubsub" {
  count  = var.create_pub_sub ? 1 : 0
  source = "../../modules/pubsub"

  topic_name   = "billing_budget_topic"
  project_id   = module.org_billing_logs.project_id
  create_topic = true
  enable_cmek  = var.enable_cmek_pubsub
}

/******************************************
  Project for Org-wide Secrets
*****************************************/
module "org_secrets" {
  source                      = "../../modules/project_baseline"
  primary_contact             = local.secret_admin
  environment                 = local.environment
  project_name                = "secrets"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  billing_code                = local.billing_code
  folder_id                   = google_folder.common.id
  activate_apis               = ["logging.googleapis.com", "bigquery.googleapis.com", "billingbudgets.googleapis.com"]
  budget_alert_pubsub_topic   = var.org_secrets_project_alert_pubsub_topic
  budget_alert_spent_percents = var.org_secrets_project_alert_spent_percents
  budget_amount               = var.org_secrets_project_budget_amount
}

/******************************************
  Project for Interconnect
*****************************************/

module "interconnect" {
  source                      = "../../modules/project_baseline"
  environment                 = local.environment
  project_name                = "interconnect"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  billing_code                = local.billing_code
  folder_id                   = google_folder.common.id
  activate_apis               = ["billingbudgets.googleapis.com", "compute.googleapis.com"]
  budget_alert_pubsub_topic   = var.interconnect_project_alert_pubsub_topic
  budget_alert_spent_percents = var.interconnect_project_alert_spent_percents
  budget_amount               = var.interconnect_project_budget_amount
}

/******************************************
  Project for SCC Notifications
*****************************************/

module "scc_notifications" {
  source                      = "../../modules/project_baseline"
  primary_contact             = local.scc_admins
  environment                 = local.environment
  project_name                = "scc"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  billing_code                = local.billing_code
  folder_id                   = google_folder.common.id
  activate_apis               = ["logging.googleapis.com", "pubsub.googleapis.com", "securitycenter.googleapis.com", "billingbudgets.googleapis.com"]
  budget_alert_pubsub_topic   = var.scc_notifications_project_alert_pubsub_topic
  budget_alert_spent_percents = var.scc_notifications_project_alert_spent_percents
  budget_amount               = var.scc_notifications_project_budget_amount
}

/******************************************
  Project for DNS Hub
*****************************************/

module "dns_hub" {
  source          = "../../modules/project_baseline"
  environment     = local.environment
  project_name    = "dns-hub"
  org_id          = var.org_id
  billing_account = var.billing_account
  billing_code    = local.billing_code
  folder_id       = google_folder.common.id
  activate_apis = [
    "compute.googleapis.com",
    "dns.googleapis.com",
    "servicenetworking.googleapis.com",
    "logging.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "billingbudgets.googleapis.com"
  ]
  budget_alert_pubsub_topic   = var.dns_hub_project_alert_pubsub_topic
  budget_alert_spent_percents = var.dns_hub_project_alert_spent_percents
  budget_amount               = var.dns_hub_project_budget_amount
}

/******************************************
  Project for Base Network Hub
*****************************************/

module "base_network_hub" {
  source          = "../../modules/project_baseline"
  count           = var.enable_hub_and_spoke ? 1 : 0
  environment     = local.environment
  project_name    = "base-net-hub"
  org_id          = var.org_id
  billing_account = var.billing_account
  billing_code    = local.billing_code
  folder_id       = google_folder.common.id
  activate_apis = [
    "compute.googleapis.com",
    "dns.googleapis.com",
    "servicenetworking.googleapis.com",
    "logging.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "billingbudgets.googleapis.com"
  ]
  budget_alert_pubsub_topic   = var.base_net_hub_project_alert_pubsub_topic
  budget_alert_spent_percents = var.base_net_hub_project_alert_spent_percents
  budget_amount               = var.base_net_hub_project_budget_amount
}

/******************************************
  Project for Restricted Network Hub
*****************************************/
module "restricted_network_hub" {
  source          = "../../modules/project_baseline"
  count           = var.enable_hub_and_spoke ? 1 : 0
  environment     = local.environment
  project_name    = "restrict-net"
  org_id          = var.org_id
  billing_account = var.billing_account
  billing_code    = local.billing_code
  folder_id       = google_folder.common.id
  activate_apis = [
    "compute.googleapis.com",
    "dns.googleapis.com",
    "servicenetworking.googleapis.com",
    "logging.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "billingbudgets.googleapis.com"
  ]
  budget_alert_pubsub_topic   = var.restricted_net_hub_project_alert_pubsub_topic
  budget_alert_spent_percents = var.restricted_net_hub_project_alert_spent_percents
  budget_amount               = var.restricted_net_hub_project_budget_amount
}
