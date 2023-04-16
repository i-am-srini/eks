locals {
  tf_sa = var.terraform_service_account
}

terraform {
  required_version = ">= 0.13"
}

/******************************************
  Provider credential configuration
 *****************************************/
provider "google" {
  impersonate_service_account = local.tf_sa
}

provider "google-beta" {
  impersonate_service_account = local.tf_sa
}
