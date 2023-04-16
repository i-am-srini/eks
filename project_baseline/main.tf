locals {
  env_code        = var.environment
  shared_vpc_mode = var.enable_hub_and_spoke ? "-spoke" : ""
}

data "google_projects" "projects" {
  count  = var.vpc_type == "" ? 0 : 1
  filter = "parent.id:${split("/", var.folder_id)[1]} labels.application_name=${var.vpc_type}-shared-vpc-host labels.environment=${var.environment} lifecycleState=ACTIVE"
}

data "google_compute_network" "shared_vpc" {
  count   = var.vpc_type == "" ? 0 : 1
  name    = "vpc-${local.env_code}-shared-${var.vpc_type}${local.shared_vpc_mode}"
  project = data.google_projects.projects[0].projects[0].project_id
}

data "google_projects" "billing_project" {
  filter = "labels.project_purpose=billing_budget lifecycleState=ACTIVE"
}

module "project" {
  source                  = "terraform-google-modules/project-factory/google"
  version                 = "~> 11.0"
  random_project_id       = true
  bucket_versioning       = true
  default_service_account = "deprivilege"
  activate_apis = var.fortress_deployment == "hub" ? distinct(concat(var.activate_apis,
    [
      "appengine.googleapis.com",
      "billingbudgets.googleapis.com",
      "cloudasset.googleapis.com",
      "cloudbuild.googleapis.com",
      "clouddebugger.googleapis.com",
      "cloudfunctions.googleapis.com",
      "cloudkms.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      "cloudscheduler.googleapis.com",
      "cloudtasks.googleapis.com",
      "dns.googleapis.com",
      "firebaserules.googleapis.com",
      "firestore.googleapis.com",
      "iam.googleapis.com",
      "iamcredentials.googleapis.com",
      "logging.googleapis.com",
      "monitoring.googleapis.com",
      "pubsub.googleapis.com",
      "secretmanager.googleapis.com",
      "servicemanagement.googleapis.com",
      "serviceusage.googleapis.com",
      "sourcerepo.googleapis.com",
      "storage.googleapis.com",
      "storage-api.googleapis.com",
      "storage-component.googleapis.com"
  ])) : distinct(concat(var.activate_apis, ["billingbudgets.googleapis.com"]))
  name            = var.project_prefix != "" ? "${var.project_prefix}-${local.env_code}-${var.project_name}" : "slz-${local.env_code}-${var.project_name}"
  org_id          = var.org_id
  billing_account = var.billing_account
  folder_id       = var.folder_id

  svpc_host_project_id = var.vpc_type == "" ? "" : data.google_compute_network.shared_vpc[0].project
  shared_vpc_subnets   = var.vpc_type == "" ? [] : data.google_compute_network.shared_vpc[0].subnetworks_self_links # Optional: To enable subnetting, replace to "module.networking_project.subnetwork_self_link"

  vpc_service_control_attach_enabled = var.vpc_service_control_attach_enabled
  vpc_service_control_perimeter_name = var.vpc_service_control_perimeter_name

  labels = merge({
    environment       = var.environment
    billing_code      = var.billing_code
    primary_contact   = element(split("@", var.primary_contact), 0)
    secondary_contact = element(split("@", var.secondary_contact), 0)
    env_code          = local.env_code
    vpc_type          = var.vpc_type
  }, var.labels)
  budget_alert_pubsub_topic   = var.budget_alert_pubsub_topic == "" ? "projects/${data.google_projects.billing_project.projects[0].project_id}/topics/billing_budget_topic" : var.budget_alert_pubsub_topic
  budget_alert_spent_percents = var.budget_alert_spent_percents
  budget_amount               = var.budget_amount
}

# Additional roles to project deployment SA created by project factory
resource "google_project_iam_member" "app_infra_pipeline_sa_roles" {
  for_each = toset(var.sa_roles)
  project  = module.project.project_id
  role     = each.value
  member   = "serviceAccount:${module.project.service_account_email}"
}

resource "google_folder_iam_member" "folder_browser" {
  count  = var.enable_cloudbuild_deploy ? 1 : 0
  folder = var.folder_id
  role   = "roles/browser"
  member = "serviceAccount:${module.project.service_account_email}"
}

resource "google_folder_iam_member" "folder_network_viewer" {
  count  = var.enable_cloudbuild_deploy ? 1 : 0
  folder = var.folder_id
  role   = "roles/compute.networkViewer"
  member = "serviceAccount:${module.project.service_account_email}"
}

# Allow Cloud Build SA to impersonate deployment SA
resource "google_service_account_iam_member" "cloudbuild_terraform_sa_impersonate_permissions" {
  count              = var.enable_cloudbuild_deploy ? 1 : 0
  service_account_id = module.project.service_account_name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${var.cloudbuild_sa}"
}

module "logging" {
  source            = "../logging_and_monitoring"
  sinks             = var.sinks
  monitoring_alerts = var.monitoring_alerts
  project_id        = module.project.project_id
}

module "fortress" {
  count            = var.enable_fortress ? 1 : 0
  source           = "../fortress"
  deployment       = var.fortress_deployment
  hub_project_id   = var.fortress_deployment == "hub" ? module.project.project_id : var.fortress_hub_project_id
  spoke_project_id = var.fortress_deployment == "spoke" ? module.project.project_id : ""
}

module "firestore" {
  count            = var.enable_firestore == true && var.fortress_deployment == "hub" ? 1 : 0
  source           = "../firestore"
  project_id       = module.project.project_id
  enable_firestore = var.enable_firestore
}
