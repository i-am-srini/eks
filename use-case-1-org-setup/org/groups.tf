locals {
  default_groups = {
    billing = {
      id           = var.billing_data_users == "" ? "billing-data-users@${var.domain}" : length(split("@", var.billing_data_users)) > 1 ? var.billing_data_users : "${var.billing_data_users}@${var.domain}"
      roles        = ["roles/billing.viewer"]
      display_name = "billing data users"
      description  = "Access billing data for the org"
      create_group = var.billing_data_users == "" ? true : false
    },
    audit = {
      id           = var.audit_data_users == "" ? "audit-data-users@${var.domain}" : length(split("@", var.audit_data_users)) > 1 ? var.audit_data_users : "${var.audit_data_users}@${var.domain}"
      roles        = ["roles/bigquery.dataViewer", "roles/bigquery.user"]
      display_name = "audit data users"
      description  = "Access audit logs for the org"
      create_group = var.audit_data_users == "" ? true : false
    },
    scc_admin = {
      id           = var.scc_admins == "" ? "scc-admin@${var.domain}" : length(split("@", var.scc_admins)) > 1 ? var.scc_admins : "${var.scc_admins}@${var.domain}"
      roles        = ["roles/securitycenter.adminEditor"]
      display_name = "scc admin"
      description  = "Security and Command Center admin"
      create_group = var.scc_admins == "" ? true : false
    },
    scc_auditor = {
      id           = var.scc_auditors == "" ? "scc-auditors@${var.domain}" : length(split("@", var.scc_auditors)) > 1 ? var.scc_auditors : "${var.scc_auditors}@${var.domain}"
      roles        = ["roles/securitycenter.adminViewer"]
      display_name = "scc auditors"
      description  = "Security and Command Center auditors"
      create_group = var.scc_auditors == "" ? true : false
    },
    scc_analyst = {
      id           = var.scc_analysts == "" ? "scc-analyst@${var.domain}" : length(split("@", var.scc_analysts)) > 1 ? var.scc_analysts : "${var.scc_analysts}@${var.domain}"
      roles        = ["roles/securitycenter.findingsEditor"]
      display_name = "scc analysts"
      description  = "Security and Command Center analysts"
      create_group = var.scc_analysts == "" ? true : false
    },
    org_secret_admin = {
      id           = var.secret_admin == "" ? "org-secret-admin@${var.domain}" : length(split("@", var.secret_admin)) > 1 ? var.secret_admin : "${var.secret_admin}@${var.domain}"
      roles        = ["roles/secretmanager.admin"]
      display_name = "org secret admin"
      description  = "Admin of the organisation level secrets"
      create_group = var.secret_admin == "" ? true : false
    },
    org_secret_analyst = {
      id           = var.secret_analysts == "" ? "org-secret-analysts@${var.domain}" : length(split("@", var.secret_analysts)) > 1 ? var.secret_analysts : "${var.secret_analysts}@${var.domain}"
      roles        = ["roles/secretmanager.viewer", "roles/secretmanager.secretVersionManager"]
      display_name = "org secret analysts"
      description  = "Organisation level secrets analysts"
      create_group = var.secret_analysts == "" ? true : false
    },
    gcs_admin = {
      id           = var.gcs_admin == "" ? "gcs_admin@${var.domain}" : length(split("@", var.gcs_admin)) > 1 ? var.gcs_admin : "${var.gcs_admin}@${var.domain}"
      roles        = ["roles/storage.admin"]
      display_name = "gcs admin"
      description  = "Organisation level gcs admin"
      create_group = var.gcs_admin == "" ? true : false
    },
    gcs_write = {
      id           = var.gcs_write == "" ? "gcs_write@${var.domain}" : length(split("@", var.gcs_write)) > 1 ? var.gcs_write : "${var.gcs_write}@${var.domain}"
      roles        = ["roles/storage.objectCreator", "roles/storage.objectViewer"]
      display_name = "gcs write"
      description  = "Organisation level gcs write"
      create_group = var.gcs_write == "" ? true : false
    },
  }
  merged_groups      = merge(local.default_groups, var.groups)
  billing_data_users = var.billing_data_users == "" ? module.groups["billing"].id : var.billing_data_users
  audit_data_users   = var.audit_data_users == "" ? module.groups["audit"].id : var.audit_data_users
  scc_admins         = var.scc_admins == "" ? module.groups["scc_admin"].id : var.scc_admins
  secret_admin       = var.secret_admin == "" ? module.groups["org_secret_admin"].id : var.secret_admin
}

module "groups" {
  source   = "terraform-google-modules/group/google"
  version  = "0.2.0"
  for_each = { for group_name, group in local.merged_groups : group_name => group if group.create_group }

  id           = each.value.id
  display_name = each.value.display_name
  description  = each.value.description
  domain       = var.domain
  owners       = var.group_owners
}

resource "google_organization_iam_member" "group_iam" {
  for_each = { for tuple in flatten([for group_name, group in local.merged_groups : [for role in group.roles : { "id" = group.create_group ? module.groups[group_name].id : group.id, "role" = role }]]) : tuple.role => tuple.id }
  org_id   = var.org_id
  role     = each.key
  member   = "group:${each.value}"
}
