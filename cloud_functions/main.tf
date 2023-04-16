module "cf_bucket" {
  source               = "../gcs"
  project_id           = var.project_id
  names                = [var.bucket_name]
  use_existing_keyring = true
  keyring_name         = var.keyring_name
  bucket_location      = var.region
  storage_class        = "REGIONAL"
  prevent_destroy      = false
}

resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = module.cf_bucket.name
  source = "/files/${var.storage_bucket_object_source}"
}

resource "google_cloud_scheduler_job" "job" {
  count = var.create_scheduler_job ? 1 : 0

  name        = var.job_name
  project     = var.project_id
  region      = var.region
  description = var.job_description
  schedule    = var.job_schedule
  time_zone   = var.time_zone

  dynamic "pubsub_target" {
    for_each = var.scheduler_http_method != null ? [] : [1]
    content {
      topic_name = var.topic_name
      data       = var.message_data
    }
  }

  dynamic "http_target" {
    for_each = var.scheduler_http_method != null ? [1] : []
    content {
      http_method = var.scheduler_http_method
      uri         = "https://${var.region}-${var.project_id}.cloudfunctions.net/${google_cloudfunctions_function.function.name}"
      body        = base64encode(var.scheduler_http_body)
    }
  }

}

resource "google_cloudfunctions_function" "function" {
  name                  = "${var.function_prefix}-function"
  runtime               = var.runtime
  project               = var.project_id
  region                = var.region
  timeout               = 540
  labels                = var.labels
  available_memory_mb   = var.available_memory_mb
  source_archive_bucket = module.cf_bucket.name
  source_archive_object = google_storage_bucket_object.archive.name

  entry_point  = var.entry_point
  trigger_http = var.trigger_http

  dynamic "event_trigger" {
    for_each = var.trigger_http != null ? {} : var.event_triggers
    content {
      event_type = event_trigger.value.event_type
      resource   = event_trigger.value.resource
    }
  }
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = var.invoker_member
}
