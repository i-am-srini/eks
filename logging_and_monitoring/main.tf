resource "google_logging_project_sink" "logging_sink" {
  for_each               = var.sinks
  project                = var.project_id
  name                   = each.value["name"]
  destination            = each.value["destination"]
  filter                 = each.value["filter"]
  unique_writer_identity = lookup(each.value, "unique_writer_identity", false)
}

resource "google_monitoring_alert_policy" "monitoring_alert" {
  for_each     = var.monitoring_alerts
  display_name = each.value["display_name"]
  combiner     = each.value["combiner"]
  conditions {
    display_name = each.value.display_name_condition
    condition_threshold {
      filter     = each.value.filter
      duration   = each.value.duration
      comparison = each.value.comparison
      aggregations {
        alignment_period   = each.value.alignment_period
        per_series_aligner = each.value.per_series_aligner
      }
    }
  }
}
