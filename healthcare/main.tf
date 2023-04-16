module "healthcare_sa" {
  count        = var.healthcare_sa == "" ? 1 : 0
  source       = "../service_account"
  account_id   = "healthcare-sa"
  project_id   = var.project_id
  display_name = "healthcare_service_account"
  description  = "Create a new service account for healthcare"
}

module "healthcare_bigquery" {
  count  = var.create_big_query ? 1 : 0
  source = "../big_query"

  project_id   = var.project_id
  dataset_name = var.dataset_name
  location     = var.healthcare_location
  enable_cmek  = var.enable_cmek
  tables       = var.tables
}

module "healthcare_pubsub" {
  count  = var.create_pub_sub ? 1 : 0
  source = "../pubsub"

  topic_name   = var.topic_name
  project_id   = var.project_id
  location     = var.healthcare_location
  create_topic = true
  enable_cmek  = var.enable_cmek
}

locals {
  sa_member    = var.healthcare_sa == "" ? "serviceAccount:${module.healthcare_sa[0].account_id}@${var.project_id}.iam.gserviceaccount.com" : var.healthcare_sa
  pubsub_topic = var.create_pub_sub ? "projects/${var.project_id}/topics/${module.healthcare_pubsub[0].topic_name}" : "projects/${var.project_id}/topics/${var.topic_name}"
  table_uri    = var.create_big_query ? "bq://${var.project_id}.${module.healthcare_bigquery[0].bigquery_dataset.dataset_id}.${element(module.healthcare_bigquery[0].table_ids, 0)}" : "bq://${var.project_id}.${var.dataset_id}.${var.table_id}"
}

# To be filled in and executed by user
module "healthcare" {
  source  = "terraform-google-modules/healthcare/google"
  version = "~> 2.1"

  name           = var.healthcare_name
  project        = var.project_id
  location       = var.healthcare_location
  iam_members    = var.iam_members
  dicom_stores   = var.dicom_stores
  fhir_stores    = var.fhir_stores
  hl7_v2_stores  = var.hl7_v2_stores
  consent_stores = var.consent_stores
}
