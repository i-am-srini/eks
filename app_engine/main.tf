resource "google_app_engine_application" "app" {
  count         = var.initialize_app ? 1 : 0
  project       = var.project_id
  location_id   = var.location
  database_type = var.database_type
}

resource "google_app_engine_standard_app_version" "app-engine" {
  count = var.create_app ? 1 : 0
  depends_on = [
    google_app_engine_application.app
  ]
  version_id = var.initialize_app ? "v1" : var.version_id
  service    = var.initialize_app ? "default" : var.service
  runtime    = var.runtime
  project    = var.project_id
  dynamic entrypoint {
    for_each = var.entrypoint != null ? [1] : []
    content {
      shell = var.entrypoint
    }
  }
  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${module.gcs_buckets[0].name}/${google_storage_bucket_object.object[0].name}"
    }
  }
  env_variables = var.env_variables
  dynamic basic_scaling {
    for_each = var.basic_scaling != null ? [1] : []
    content {
      max_instances = var.basic_scaling
    }
  }
  noop_on_destroy           = false
  delete_service_on_destroy = var.initialize_app || var.service == "default" ? false : true
}

module "gcs_buckets" {
  count           = var.create_app ? 1 : 0
  source          = "../gcs/"
  names           = [var.source_code_bucket]
  bucket_location = var.location
  project_id      = var.project_id
  labels          = var.labels
  lifecycle_rules = []
  storage_class   = "REGIONAL"
  enable_cmek     = var.enable_cmek
}

resource "google_storage_bucket_object" "object" {
  count  = var.create_app ? 1 : 0
  name   = "source.zip"
  bucket = module.gcs_buckets[0].name
  source = fileexists("${path.module}/app_source/source.zip") ? "${path.module}/app_source/source.zip" : data.archive_file.source_code_zip[0].output_path
}

data "archive_file" "source_code_zip" {
  count       = fileexists("${path.module}/app_source/source.zip") || var.create_app == false ? 0 : 1
  type        = "zip"
  source_dir  = "${path.module}/app_source"
  output_path = "${path.module}/app_source/zipped_source.zip"

  dynamic source {
    for_each = [for file in fileset("/app_source", "*") : file]
    content {
      content  = join("/", ["/app_source", source.value])
      filename = join("/", ["/app_source", source.value])
    }
  }
}
