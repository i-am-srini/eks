locals {
  dataset_id = "${var.bq_dataset_prefix}${lower(var.dataset_name)}bq${random_string.bq_suffix.result}"
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "random_string" "bq_suffix" {
  length  = 5
  upper   = false
  number  = true
  lower   = true
  special = false
}

module "kms" {
  count                = var.enable_cmek ? 1 : 0
  source               = "../kms/"
  project_id           = var.project_id
  use_existing_keyring = var.use_existing_keyring
  keyring              = var.keyring_name
  location             = var.location
  keys                 = ["bq-${local.dataset_id}-key"]
  key_rotation_period  = var.key_rotation_period
  encrypters           = ["serviceAccount:bq-${data.google_project.project.number}@bigquery-encryption.iam.gserviceaccount.com"]
  set_encrypters_for   = ["bq-${local.dataset_id}-key"]
  decrypters           = ["serviceAccount:bq-${data.google_project.project.number}@bigquery-encryption.iam.gserviceaccount.com"]
  set_decrypters_for   = ["bq-${local.dataset_id}-key"]
  prevent_destroy      = var.prevent_destroy
}

module "bigquery" {
  depends_on                 = [module.kms]
  source                     = "terraform-google-modules/bigquery/google"
  version                    = "~> 5.2"
  dataset_id                 = local.dataset_id
  dataset_name               = local.dataset_id
  description                = var.description
  project_id                 = var.project_id
  location                   = var.location
  delete_contents_on_destroy = var.delete_contents_on_destroy
  deletion_protection        = var.deletion_protection
  dataset_labels             = var.labels
  encryption_key             = var.enable_cmek ? module.kms[0].keys["bq-${local.dataset_id}-key"] : null
  tables                     = var.tables
}
