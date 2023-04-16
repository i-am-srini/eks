terraform {
  backend "gcs" {
    bucket = "UPDATE_ME"
    prefix = "terraform/cloud-functions/state"
  }
}
