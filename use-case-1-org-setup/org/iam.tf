resource "google_organization_iam_audit_config" "org_config" {
  count   = var.data_access_logs_enabled ? 1 : 0
  org_id  = var.parent_folder == "" ? var.org_id : "folders/${var.parent_folder}"
  service = "allServices"

  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
  audit_log_config {
    log_type = "ADMIN_READ"
  }
}

/******************************************
  Security Notification Service Account
*****************************************/
resource "random_string" "sa_sufix" {
  length  = 8
  special = false
  lower   = true
  upper   = false
  number  = true
}

module "org_service_account" {
  source       = "../../modules/service_account"
  account_id   = "custom-finding-source-${random_string.sa_sufix.result}"
  display_name = "Custom finding source integration SA"
  description  = "service account for Custom finding source integration to SCC"
  project_id   = module.scc_notifications.project_id
}

resource "google_project_iam_member" "sa_iam" {
  project = module.org_secrets.project_id
  role    = "roles/securitycenter.findingsEditor"
  member  = "serviceAccount:${module.org_service_account.email}"
}
