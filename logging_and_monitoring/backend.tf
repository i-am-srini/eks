terraform {
  backend "gcs" {
    bucket = "UPDATE_ME"
    prefix = "terraform/logging_and_monitoring/state"
  }
}
