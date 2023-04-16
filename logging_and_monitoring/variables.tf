variable "project_id" {
  description = "Project id where the logging sink is created."
  type        = string
}

variable "sinks" {
  description = "logging sinks settings"
  type = map(object({
    name                   = string
    destination            = string
    filter                 = string
    unique_writer_identity = bool
  }))
  default = {
    "my-test" = {
      name                   = "my-test"
      destination            = "storage.googleapis.com/testrinat"
      filter                 = "resource.type = gcs.instance AND severity >=WARNING"
      unique_writer_identity = true
    }
  }
}

variable "monitoring_alerts" {
  type = map(object({
    display_name           = string
    combiner               = string
    display_name_condition = string
    filter                 = string
    duration               = string
    comparison             = string
    alignment_period       = string
    per_series_aligner     = string
  }))
  default = {
    test = {
      display_name           = "test"
      combiner               = "OR"
      display_name_condition = "new test condition"
      filter                 = "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\""
      duration               = "60s"
      comparison             = "COMPARISON_GT"
      alignment_period       = "60s"
      per_series_aligner     = "ALIGN_RATE"
    }
  }
}
