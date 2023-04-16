locals {
  organization_id = var.org_id != "" ? var.org_id : null
  folder_id       = var.org_id == "" ? null : var.folder_id != "" ? var.folder_id : null
  project_id      = var.project_id != "" ? var.project_id : null
  policy_for      = var.project_id != "" ? "project" : var.folder_id != "" ? "folder" : "organization"
  env_config      = var.env == "dev" || var.env == "nonprod" || var.env == "prod" ? var.env : "org"
}

/**************************************************
  Organization Policies Creation by Environments
***************************************************/

module "org_policies" {
  source            = "terraform-google-modules/org-policy/google"
  for_each          = fileset("${path.module}/policiesDefinitionsJson/${local.env_config}", "*.json")
  version           = "~> 3.0"
  organization_id   = local.organization_id
  folder_id         = local.folder_id
  project_id        = local.project_id
  policy_for        = local.policy_for
  constraint        = jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).constraint
  policy_type       = jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).policy_type
  enforce           = jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).enforce
  allow             = jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).policy_type == "list" ? jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).allow : [""]
  allow_list_length = jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).policy_type == "list" ? jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).allow_list_length : 0
  deny              = jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).policy_type == "list" ? jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).deny : [""]
  deny_list_length  = jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).policy_type == "list" ? jsondecode(file("${path.module}/policiesDefinitionsJson/${local.env_config}/${each.value}")).deny_list_length : 0
}
