terraform {
  backend "gcs" {
    bucket = "UPDATE_ME"
    prefix = "terraform/policies/state"
  }
}
