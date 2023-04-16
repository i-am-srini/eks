locals {
  read_replicas = {
    tier = var.tier
    ip_configuration = {
      ipv4_enabled        = false
      require_ssl         = true
      private_network     = data.google_compute_network.vpc[0].self_link
      authorized_networks = var.authorized_networks
    }
    database_flags  = var.database_flags
    disk_autoresize = null
    disk_size       = null
    disk_type       = "PD_HDD"
    user_labels     = {}
  }
}

data "google_compute_network" "vpc" {
  count   = var.shared_vpc_project_id == "" || var.shared_vpc_name == "" ? 0 : 1
  project = var.shared_vpc_project_id
  name    = var.shared_vpc_name
}

module "sql_db_private_service_access" {
  source      = "GoogleCloudPlatform/sql-db/google//modules/private_service_access"
  version     = "7.0.0"
  project_id  = var.project_id
  vpc_network = var.shared_vpc_name
}

module "cloud_sql_bastion" {
  source                       = "../bastion/"
  project_id                   = var.project_id
  bastion_name                 = var.bastion_instance_name
  bastion_zone                 = var.zone
  bastion_region               = var.region
  bastion_service_account_name = var.bastion_service_account_name
  bastion_subnet               = var.bastion_subnet
  network_project_id           = var.shared_vpc_project_id
  vpc_name                     = var.shared_vpc_name
  create_bastion_group         = true
  bastion_group_id             = var.sql_group_id
  bastion_group_owners         = var.sql_group_owners
  bastion_members              = var.sql_group_members
}

resource "random_password" "root_password_sufix" {
  length  = 8
  special = true
}

resource "google_secret_manager_secret" "secrets" {
  secret_id = "sql-secret"
  project   = var.project_id
  labels = {
    label = "cloudsql"
  }
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret_versions" {
  secret      = google_secret_manager_secret.secrets.id
  secret_data = var.root_password == "" ? "${var.database_type}-${random_password.root_password_sufix.result}" : var.root_password
}

resource "google_secret_manager_secret_iam_binding" "binding" {
  project   = google_secret_manager_secret.secrets.project
  secret_id = google_secret_manager_secret.secrets.secret_id
  role      = "roles/secretmanager.secretAccessor"
  members   = ["group:${module.cloud_sql_bastion.group_email}"]
}
