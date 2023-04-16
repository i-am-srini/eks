/******************************************
  Top level folders
 *****************************************/
locals {
  parent = var.parent_folder != "" ? "folders/${var.parent_folder}" : "organizations/${var.org_id}"
}

resource "google_folder" "common" {
  display_name = "${var.folder_prefix}-common"
  parent       = local.parent
}

module "organization_policies_org" {
  source    = "../../modules/policies"
  folder_id = google_folder.common.id
  env       = "org"
}

resource "google_access_context_manager_access_policy" "access_policy" {
  count  = var.create_acm_policy ? 1 : 0
  parent = "organizations/${var.org_id}"
  title  = "default policy"
}
