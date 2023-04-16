locals {
  parent = var.parent_id
}

/******************************************
  Environment Folder
*****************************************/

resource "google_folder" "env" {
  display_name = "${var.folder_prefix}-${var.env}"
  parent       = local.parent
}

module "organization_policies_envs" {
  source    = "../policies"
  folder_id = google_folder.env.id
  env       = var.env
}

module "fortress" {
  count             = var.enable_fortress ? 1 : 0
  source            = "../fortress"
  deployment        = "folder"
  hub_project_id    = var.fortress_hub_project_id
  spoke_folder_name = google_folder.env.id
}
