/******************************************
  Projects for Shared VPCs
*****************************************/

module "base_shared_vpc_host_project" {
  source          = "../project_baseline"
  project_name    = "base-svpc"
  environment     = var.env
  org_id          = var.org_id
  billing_account = var.billing_account
  folder_id       = google_folder.env.id
  activate_apis = [
    "compute.googleapis.com",
    "dns.googleapis.com",
    "servicenetworking.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "billingbudgets.googleapis.com"
  ]
  billing_code                = var.billing_code
  primary_contact             = var.primary_contact
  budget_alert_pubsub_topic   = var.base_network_project_alert_pubsub_topic
  budget_alert_spent_percents = var.base_network_project_alert_spent_percents
  budget_amount               = var.base_network_project_budget_amount
  labels = {
    "application_name" = "base-shared-vpc-host"
    "environment"      = var.env
  }
}

module "restricted_shared_vpc_host_project" {
  source          = "../project_baseline"
  project_name    = "restrict-svpc"
  environment     = var.env
  org_id          = var.org_id
  billing_account = var.billing_account
  folder_id       = google_folder.env.id
  activate_apis = [
    "compute.googleapis.com",
    "dns.googleapis.com",
    "servicenetworking.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "accesscontextmanager.googleapis.com",
    "billingbudgets.googleapis.com"
  ]
  billing_code                = var.billing_code
  primary_contact             = var.primary_contact
  budget_alert_pubsub_topic   = var.restricted_network_project_alert_pubsub_topic
  budget_alert_spent_percents = var.restricted_network_project_alert_spent_percents
  budget_amount               = var.restricted_network_project_budget_amount
  labels = {
    "application_name" = "restricted-shared-vpc-host"
    "environment"      = var.env
  }
}

/******************************************
  Monitoring - IAM
*****************************************/

resource "google_project_iam_member" "monitoring_editor" {
  project = module.monitoring_project.project_id
  role    = "roles/monitoring.editor"
  member  = "group:${var.monitoring_workspace_users}"
}

/******************************************
  Projects for monitoring workspaces
*****************************************/

module "monitoring_project" {
  source          = "../project_baseline"
  project_name    = "monitoring"
  environment     = var.env
  org_id          = var.org_id
  billing_account = var.billing_account
  folder_id       = google_folder.env.id
  activate_apis = [
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "billingbudgets.googleapis.com"
  ]
  billing_code                = var.billing_code
  primary_contact             = var.primary_contact
  budget_alert_pubsub_topic   = var.monitoring_project_alert_pubsub_topic
  budget_alert_spent_percents = var.monitoring_project_alert_spent_percents
  budget_amount               = var.monitoring_project_budget_amount
}

/******************************************
  Project for Environment Secrets
*****************************************/

module "env_secrets" {
  source                      = "../project_baseline"
  project_name                = "env-secrets"
  environment                 = var.env
  org_id                      = var.org_id
  billing_account             = var.billing_account
  folder_id                   = google_folder.env.id
  activate_apis               = ["logging.googleapis.com", "secretmanager.googleapis.com"]
  billing_code                = var.billing_code
  primary_contact             = var.primary_contact
  budget_alert_pubsub_topic   = var.secret_project_alert_pubsub_topic
  budget_alert_spent_percents = var.secret_project_alert_spent_percents
  budget_amount               = var.secret_project_budget_amount
}
