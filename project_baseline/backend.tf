terraform {
  backend "gcs" {
    bucket = "UPDATE_ME"
    prefix = "terraform/project_basline/state"
  }
}
