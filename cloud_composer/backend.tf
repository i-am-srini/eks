terraform {
  backend "gcs" {
    bucket = "UPDATE_ME"
    prefix = "terraform/cloud_composer/state"
  }
}
