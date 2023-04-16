module "org" {
  source                    = "./org/"
  org_id                    = var.org_id
  billing_account           = var.billing_account
  terraform_service_account = var.terraform_service_account
  default_region            = var.primary_region
  scc_notification_name     = var.scc_notification_name
  domain                    = var.domain
}

module "dev_env" {
  source                     = "../modules/env_baseline"
  env                        = "development"
  parent_id                  = "organizations/${var.org_id}"
  org_id                     = var.org_id
  billing_account            = var.billing_account
  monitoring_workspace_users = var.monitoring_workspace_users
  primary_contact            = var.primary_contact
  billing_code               = var.billing_code
  depends_on                 = [module.org]
}

module "non_prod_env" {
  source                     = "../modules/env_baseline"
  env                        = "non-production"
  parent_id                  = "organizations/${var.org_id}"
  org_id                     = var.org_id
  billing_account            = var.billing_account
  monitoring_workspace_users = var.monitoring_workspace_users
  primary_contact            = var.primary_contact
  billing_code               = var.billing_code
  depends_on                 = [module.org]
}

module "prod_env" {
  source                     = "../modules/env_baseline"
  env                        = "production"
  parent_id                  = "organizations/${var.org_id}"
  org_id                     = var.org_id
  billing_account            = var.billing_account
  monitoring_workspace_users = var.monitoring_workspace_users
  primary_contact            = var.primary_contact
  billing_code               = var.billing_code
  depends_on                 = [module.org]
}

module "network_dev" {
  source                            = "./networks/development"
  depends_on                        = [module.network_shared]
  org_id                            = var.org_id
  parent_folder                     = module.dev_env.env_folder
  access_context_manager_policy_id  = module.org.access_context_manager_access_policy_id
  terraform_service_account         = var.terraform_service_account
  default_region1                   = var.primary_region
  default_region2                   = var.secondary_region
  domain                            = var.domain
  optional_fw_rules_enabled         = true
  enable_hub_and_spoke              = true
  enable_hub_and_spoke_transitivity = true
  nat_enabled                       = true
}

module "network_non_prod" {
  source                            = "./networks/non-production"
  depends_on                        = [module.network_shared]
  org_id                            = var.org_id
  parent_folder                     = module.non_prod_env.env_folder
  access_context_manager_policy_id  = module.org.access_context_manager_access_policy_id
  terraform_service_account         = var.terraform_service_account
  default_region1                   = var.primary_region
  default_region2                   = var.secondary_region
  domain                            = var.domain
  optional_fw_rules_enabled         = true
  enable_hub_and_spoke              = true
  enable_hub_and_spoke_transitivity = true
  nat_enabled                       = true
}

module "network_prod" {
  source                            = "./networks/production"
  depends_on                        = [module.network_shared]
  org_id                            = var.org_id
  parent_folder                     = module.prod_env.env_folder
  access_context_manager_policy_id  = module.org.access_context_manager_access_policy_id
  terraform_service_account         = var.terraform_service_account
  default_region1                   = var.primary_region
  default_region2                   = var.secondary_region
  domain                            = var.domain
  optional_fw_rules_enabled         = true
  enable_hub_and_spoke              = true
  enable_hub_and_spoke_transitivity = true
  nat_enabled                       = true
}

module "network_shared" {
  source                                   = "./networks/shared"
  org_id                                   = var.org_id
  parent_folder                            = module.org.shared_folder
  access_context_manager_policy_id         = module.org.access_context_manager_access_policy_id
  terraform_service_account                = var.terraform_service_account
  default_region1                          = var.primary_region
  default_region2                          = var.secondary_region
  domain                                   = var.domain
  base_hub_optional_fw_rules_enabled       = true
  restricted_hub_optional_fw_rules_enabled = true
  enable_hub_and_spoke                     = true
  enable_hub_and_spoke_transitivity        = true
  base_hub_nat_enabled                     = true
  restricted_hub_nat_enabled               = true
  target_name_server_addresses             = var.target_name_server_addresses
}

module "floating_project" {
  source                      = "../modules/project_baseline"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  folder_id                   = module.dev_env.env_folder
  environment                 = "development"
  vpc_type                    = "base"
  enable_hub_and_spoke        = true
  budget_alert_spent_percents = var.alert_spent_percents
  budget_alert_pubsub_topic   = var.alert_pubsub_topic
  budget_amount               = var.budget_amount
  project_name                = "floating"
  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "stackdriver.googleapis.com",
    "compute.googleapis.com",
    "storage-component.googleapis.com"
  ]
  billing_code      = var.billing_code
  primary_contact   = element(var.contacts, 0)
  secondary_contact = element(var.contacts, 0)
}
