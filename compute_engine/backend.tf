terraform {
  backend "gcs" {
    bucket = "UPDATE_ME"
    prefix = "terraform/compute_engine/state"
  }
}
