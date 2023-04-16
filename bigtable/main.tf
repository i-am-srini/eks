resource "google_bigtable_instance" "instance" {
  name                = var.name
  project             = var.project_id
  display_name        = var.display_name
  deletion_protection = false

  cluster {
    cluster_id   = var.cluster_configuration.cluster_id
    zone         = var.cluster_configuration.zone
    num_nodes    = var.cluster_configuration.num_nodes
    storage_type = var.cluster_configuration.storage_type
    kms_key_name = var.enable_cmek ? module.bigtable_kms[0].keys["bigtable-key-${random_string.random_suffix.result}"] : null
  }
  labels = var.labels
}

resource "google_bigtable_table" "table" {
  name          = var.table_name
  instance_name = google_bigtable_instance.instance.name
  column_family {
    family = var.family
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_bigtable_app_profile" "app-profile" {
  instance       = google_bigtable_instance.instance.name
  app_profile_id = var.app_profile_id

  single_cluster_routing {
    cluster_id                 = var.cluster_configuration.cluster_id
    allow_transactional_writes = var.allow_transactional_writes
  }
  ignore_warnings = true
}

resource "google_bigtable_gc_policy" "policy" {
  instance_name = google_bigtable_instance.instance.name
  table         = google_bigtable_table.table.name
  column_family = var.family
  max_age {
    duration = var.duration
  }
}

######################
## Bigtable IAM
######################

resource "google_bigtable_instance_iam_member" "editor-instance" {
  instance = google_bigtable_instance.instance.name
  role     = "roles/bigtable.user"
  member   = var.create_bigtable_group ? "group:${module.bigtable_group[0].id}" : var.bigtable_member
}

resource "google_bigtable_table_iam_member" "editor-table" {
  table    = google_bigtable_table.table.name
  instance = google_bigtable_instance.instance.name
  role     = "roles/bigtable.user"
  member   = var.create_bigtable_group ? "group:${module.bigtable_group[0].id}" : var.bigtable_member
}

######################
## Bigtable KMS
######################

resource "random_string" "random_suffix" {
  length  = 4
  special = false
  lower   = true
  upper   = false
  number  = true
}

data "google_project" "project" {
  project_id = var.project_id
}

module "bigtable_kms" {
  count  = var.enable_cmek ? 1 : 0
  source = "../kms/"

  project_id           = var.project_id
  use_existing_keyring = var.use_existing_keyring
  keyring              = var.keyring_name
  location             = var.location
  keys                 = ["bigtable-key-${random_string.random_suffix.result}"]
  encrypters           = ["serviceAccount:service-${data.google_project.project.number}@gcp-sa-bigtable.iam.gserviceaccount.com"]
  set_encrypters_for   = ["bigtable-key-${random_string.random_suffix.result}"]
  decrypters           = ["serviceAccount:service-${data.google_project.project.number}@gcp-sa-bigtable.iam.gserviceaccount.com"]
  set_decrypters_for   = ["bigtable-key-${random_string.random_suffix.result}"]
}

module "bigtable_group" {
  source       = "terraform-google-modules/group/google"
  version      = "0.2.0"
  count        = var.create_bigtable_group ? 1 : 0
  id           = var.bigtable_group_id
  display_name = "bigtable_group"
  description  = "bigtable_group"
  domain       = split("@", var.bigtable_group_id)[1]
  owners       = var.bigtable_group_owners
}
