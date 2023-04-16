module "cloud-composer" {
  source                           = "terraform-google-modules/composer/google//modules/create_environment"
  for_each                         = var.composer_config
  region                           = var.region
  project_id                       = var.project_id
  network                          = var.network
  network_project_id               = var.network_project_id
  subnetwork_region                = var.subnetwork_region
  zone                             = var.zone
  composer_service_account         = module.service_account.email
  subnetwork                       = var.cloud_composer_subnet_self_link == "" ? data.google_compute_subnetwork.cloud_composer_subnet[0].name : var.cloud_composer_subnet_self_link
  composer_env_name                = each.value["composer_env_name"]
  labels                           = each.value["labels"]
  node_count                       = each.value["node_count"]
  machine_type                     = each.value["machine_type"]
  disk_size                        = each.value["disk_size"]
  oauth_scopes                     = each.value["oauth_scopes"]
  tags                             = each.value["tags"]
  use_ip_aliases                   = each.value["use_ip_aliases"]
  pod_ip_allocation_range_name     = each.value["pod_ip_allocation_range_name"]
  service_ip_allocation_range_name = each.value["service_ip_allocation_range_name"]
  airflow_config_overrides         = each.value["airflow_config_overrides"]
  env_variables                    = each.value["env_variables"]
  image_version                    = each.value["image_version"]
  pypi_packages                    = each.value["pypi_packages"]
  python_version                   = each.value["python_version"]
  cloud_sql_ipv4_cidr              = each.value["cloud_sql_ipv4_cidr"]
  web_server_ipv4_cidr             = each.value["web_server_ipv4_cidr"]
  master_ipv4_cidr                 = each.value["master_ipv4_cidr"]
  enable_private_endpoint          = each.value["enable_private_endpoint"]
  depends_on                       = [module.kms]
  kms_key_name                     = var.enable_cmek ? module.kms[0].keys[join("", [each.value["composer_env_name"], "-key"])] : null
}

module "kms" {
  count  = var.enable_cmek ? 1 : 0
  source = "../kms/"

  project_id           = var.project_id
  use_existing_keyring = var.use_existing_keyring
  keyring              = var.keyring
  location             = var.region
  keys                 = [for config in var.composer_config : join("", [config["composer_env_name"], "-key"])]
  key_rotation_period  = var.key_rotation_period
  encrypters = [
    "serviceAccount:${module.service_account.email}",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@cloudcomposer-accounts.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@gcp-sa-artifactregistry.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@container-engine-robot.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@gcp-sa-pubsub.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@gs-project-accounts.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@compute-system.iam.gserviceaccount.com"
  ]
  set_encrypters_for = [for config in var.composer_config : join("", [config["composer_env_name"], "-key"])]
  decrypters = [
    "serviceAccount:${module.service_account.email}",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@cloudcomposer-accounts.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@gcp-sa-artifactregistry.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@container-engine-robot.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@gcp-sa-pubsub.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@gs-project-accounts.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.cloud-composer_project.number}@compute-system.iam.gserviceaccount.com"
  ]
  set_decrypters_for = [for config in var.composer_config : join("", [config["composer_env_name"], "-key"])]
  prevent_destroy    = var.prevent_destroy
}

data "google_compute_subnetwork" "cloud_composer_subnet" {
  count   = var.cloud_composer_subnet_self_link == "" ? 1 : 0
  project = var.network_project_id
  name    = var.subnet_name
  region  = var.subnetwork_region
}

data "google_project" "cloud-composer_project" {
  project_id = var.project_id
}

module "service_account" {
  source       = "../service_account"
  account_id   = var.service-account_config["account_id"]
  project_id   = var.project_id
  display_name = var.service-account_config["display_name"]
  description  = var.service-account_config["description"]
}

resource "google_project_iam_member" "cloud_composer_worker" {
  role    = "roles/composer.worker"
  project = var.project_id
  member  = "serviceAccount:${module.service_account.email}"
}
