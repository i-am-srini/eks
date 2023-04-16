terraform {
  backend "gcs" {
    bucket = "UPDATE_ME"
    prefix = "terraform/service_account/state"
  }
}
