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

module "dataflow_kms" {
  count  = var.enable_cmek ? 1 : 0
  source = "../kms/"

  project_id           = var.project_id
  use_existing_keyring = var.use_existing_keyring
  keyring              = var.keyring_name
  location             = var.region
  keys                 = ["dataflow-key-${random_string.random_suffix.result}"]
  encrypters           = ["serviceAccount:service-${data.google_project.project.number}@dataflow-service-producer-prod.iam.gserviceaccount.com"]
  set_encrypters_for   = ["dataflow-key-${random_string.random_suffix.result}"]
  decrypters           = ["serviceAccount:service-${data.google_project.project.number}@dataflow-service-producer-prod.iam.gserviceaccount.com"]
  set_decrypters_for   = ["dataflow-key-${random_string.random_suffix.result}"]
}

data "google_compute_network" "vpc" {
  project = var.network_project_id
  name    = var.vpc_name
}

data "google_compute_subnetwork" "dataflow_subnet" {
  project = var.network_project_id
  name    = var.subnet_name
  region  = var.region
}

module "dataflow_bucket" {
  count  = var.create_bucket ? 1 : 0
  source = "../gcs"

  names           = ["${var.dataflow_bucket}-${random_string.random_suffix.result}"]
  bucket_location = var.region
  project_id      = var.project_id
  enable_cmek     = var.enable_cmek
  storage_class   = "REGIONAL"
  lifecycle_rules = []
}

resource "google_dataflow_job" "dataflow_job" {
  project                 = var.project_id
  name                    = var.df_job_name
  on_delete               = "cancel"
  kms_key_name            = var.enable_cmek ? module.dataflow_kms[0].keys["dataflow-key-${random_string.random_suffix.result}"] : null
  region                  = var.region
  zone                    = var.zone
  max_workers             = 1
  template_gcs_path       = var.template_gcs_path
  temp_gcs_location       = var.create_bucket ? module.dataflow_bucket[0].name : var.dataflow_bucket
  network                 = data.google_compute_network.vpc.self_link
  subnetwork              = data.google_compute_subnetwork.dataflow_subnet.self_link
  machine_type            = "n1-standard-1"
  parameters              = var.parameters
  additional_experiments  = var.additional_experiments
  enable_streaming_engine = var.enable_streaming_engine
  labels                  = var.labels
}
