terraform {
  backend "gcs" {
    bucket = "UPDATE_ME"
    prefix = "terraform/use-case-1-org-setup/state"
  }
}
