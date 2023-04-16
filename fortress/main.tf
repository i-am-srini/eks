locals {
  hub_roles = {
    "fortress-deployment" = [
      "roles/appengine.appAdmin",
      "roles/bigquery.admin",
      "roles/cloudbuild.builds.editor",
      "roles/cloudfunctions.admin",
      "roles/cloudscheduler.admin",
      "roles/cloudtasks.admin",
      "roles/consumerprocurement.entitlementManager",
      "roles/datastore.owner",
      "roles/iam.serviceAccountUser",
      "roles/pubsub.admin",
      "roles/resourcemanager.projectIamAdmin",
      "roles/servicemanagement.admin",
      "roles/storage.admin"
    ],
    "fortress-operational" = [
      "roles/accesscontextmanager.policyAdmin",
      "roles/serviceusage.serviceUsageConsumer",
      "roles/storage.admin",
      "roles/bigquery.admin"
    ],
    "fortress-remediation" = [
      "roles/appengine.appAdmin",
      "roles/bigquery.admin",
      "roles/cloudtasks.admin",
      "roles/datastore.owner",
      "roles/iam.securityAdmin",
      "roles/iam.serviceAccountAdmin",
      "roles/iam.serviceAccountUser",
      "roles/pubsub.admin",
      "roles/redis.admin",
      "roles/resourcemanager.projectIamAdmin",
      "roles/securitycenter.admin",
      "roles/storage.admin"
    ],
    "fortress-unit-test" = [
      "roles/appengine.appAdmin",
      "roles/bigquery.admin",
      "roles/datastore.owner",
      "roles/dns.admin",
      "roles/monitoring.admin",
      "roles/storage.admin"
    ]
  }
  folder_roles = {
    "fortress-operational" = [
      "roles/cloudprivatecatalogproducer.admin"
    ]
  }
  spoke_roles = {
    "fortress-remediation" = [
      "roles/appengine.appAdmin",
      "roles/bigquery.admin",
      "roles/cloudfunctions.admin",
      "roles/cloudkms.admin",
      "roles/cloudscheduler.admin",
      "roles/cloudsql.admin",
      "roles/compute.admin",
      "roles/container.admin",
      "roles/dns.admin",
      "roles/iam.securityAdmin",
      "roles/iam.serviceAccountAdmin",
      "roles/iam.serviceAccountKeyAdmin",
      "roles/iam.serviceAccountUser",
      "roles/logging.admin",
      "roles/monitoring.admin",
      "roles/redis.admin",
      "roles/resourcemanager.projectIamAdmin",
      "roles/secretmanager.admin",
      "roles/securitycenter.admin",
      "roles/serviceusage.serviceUsageConsumer",
      "roles/storage.admin"
    ],
    "fortress-unit-test" = [
      "roles/appengine.appAdmin",
      "roles/bigquery.admin",
      "roles/cloudfunctions.admin",
      "roles/cloudkms.admin",
      "roles/cloudsql.admin",
      "roles/compute.admin",
      "roles/container.admin",
      "roles/dns.admin",
      "roles/iam.serviceAccountAdmin",
      "roles/iam.serviceAccountKeyAdmin",
      "roles/logging.admin",
      "roles/monitoring.admin",
      "roles/resourcemanager.projectIamAdmin",
      "roles/secretmanager.admin",
      "roles/securitycenter.settingsAdmin",
      "roles/storage.admin"
    ]
  }
}

###################
##  Hub
###################
module "fortress_sa" {
  for_each     = var.deployment == "hub" ? local.hub_roles : {}
  source       = "../service_account"
  account_id   = "${var.sa_prefix}-${each.key}"
  project_id   = var.hub_project_id
  display_name = "fortress_sa"
  description  = "Service account for Fortress"
}

resource "google_project_iam_member" "fortress_hub_deployment_sa" {
  for_each = var.deployment == "hub" ? toset(local.hub_roles["fortress-deployment"]) : []
  project  = var.hub_project_id
  role     = each.value
  member   = "serviceAccount:${module.fortress_sa["fortress-deployment"].email}"
}

resource "google_project_iam_member" "fortress_hub_operational_sa" {
  for_each = var.deployment == "hub" ? toset(local.hub_roles["fortress-operational"]) : []
  project  = var.hub_project_id
  role     = each.value
  member   = "serviceAccount:${module.fortress_sa["fortress-operational"].email}"
}

resource "google_project_iam_member" "fortress_hub_remediation_sa" {
  for_each = var.deployment == "hub" ? toset(local.hub_roles["fortress-remediation"]) : []
  project  = var.hub_project_id
  role     = each.value
  member   = "serviceAccount:${module.fortress_sa["fortress-remediation"].email}"
}

resource "google_project_iam_member" "fortress_hub_unit_test_sa" {
  for_each = var.deployment == "hub" ? toset(local.hub_roles["fortress-unit-test"]) : []
  project  = var.hub_project_id
  role     = each.value
  member   = "serviceAccount:${module.fortress_sa["fortress-unit-test"].email}"
}

resource "google_secret_manager_secret" "secrets" {
  for_each  = var.deployment == "hub" ? local.hub_roles : {}
  secret_id = "${each.key}-sa-secret"
  project   = var.hub_project_id
  labels = {
    label = "fortress"
  }
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret_versions" {
  for_each    = var.deployment == "hub" ? local.hub_roles : {}
  secret      = google_secret_manager_secret.secrets[each.key].id
  secret_data = module.fortress_sa[each.key].service_account_private_key
}

###################
##  Spoke Project
###################

resource "google_project_iam_member" "fortress_spoke_remediation_sa" {
  for_each = var.deployment == "spoke" ? toset(local.spoke_roles["fortress-remediation"]) : []
  project  = var.spoke_project_id
  role     = each.value
  member   = "serviceAccount:${var.sa_prefix}-fortress-remediation@${var.hub_project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "fortress_spoke_unit_test_sa" {
  for_each = var.deployment == "spoke" ? toset(local.spoke_roles["fortress-unit-test"]) : []
  project  = var.spoke_project_id
  role     = each.value
  member   = "serviceAccount:${var.sa_prefix}-fortress-unit-test@${var.hub_project_id}.iam.gserviceaccount.com"
}

###################
##  Spoke Folder
###################

resource "google_folder_iam_member" "fortress_folder_operational_sa" {
  for_each = var.deployment == "folder" ? toset(local.folder_roles["fortress-operational"]) : []
  folder   = var.spoke_folder_name
  role     = each.value
  member   = "serviceAccount:${var.sa_prefix}-fortress-operational@${var.hub_project_id}.iam.gserviceaccount.com"
}
