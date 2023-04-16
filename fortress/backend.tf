terraform {
  backend "gcs" {
    bucket = "UPDATE_ME"
    prefix = "terraform/fortress/state"
  }
}
