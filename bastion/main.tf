locals {
  container_roles = [
    "roles/compute.admin",
    "roles/gkehub.admin",
    "roles/container.admin",
    "roles/meshconfig.admin",
    "roles/resourcemanager.projectIamAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountKeyAdmin",
    "roles/servicemanagement.admin",
    "roles/serviceusage.serviceUsageAdmin",
    "roles/privateca.admin"
  ]
}

data "google_compute_network" "vpc" {
  count   = var.network_project_id == "" || var.vpc_name == "" ? 0 : 1
  project = var.network_project_id
  name    = var.vpc_name
}

data "google_compute_subnetwork" "bastion_subnet" {
  count   = var.network_project_id == "" || var.bastion_subnet == "" || var.bastion_region == "" ? 0 : 1
  project = var.network_project_id
  name    = var.bastion_subnet
  region  = var.bastion_region
}

module "iap_bastion" {
  source  = "terraform-google-modules/bastion-host/google"
  version = "~> 3.2"
  project = var.project_id

  # Variables for existing network
  network      = var.vpc_self_link == "" ? data.google_compute_network.vpc[0].self_link : var.vpc_self_link
  subnet       = var.bastion_subnet_self_link == "" ? data.google_compute_subnetwork.bastion_subnet[0].self_link : var.bastion_subnet_self_link
  host_project = var.network_project_id

  # Customizable Variables
  name                               = var.bastion_name
  zone                               = var.bastion_zone
  service_account_name               = var.bastion_service_account_email == "" ? var.bastion_service_account_name : ""
  service_account_email              = var.bastion_service_account_name == "" ? var.bastion_service_account_email : ""
  service_account_roles_supplemental = var.enable_container_access ? concat(var.other_roles, local.container_roles) : var.other_roles
  create_firewall_rule               = true
  shielded_vm                        = true
  members                            = var.create_bastion_group ? ["group:${module.bastion_group[0].id}"] : var.bastion_members
  tags                               = ["bastion", "allow-google-apis", "egress-internet"]
}

resource "google_project_iam_member" "bastion_repo_access" {
  count   = var.repo_project_id == "" ? 0 : 1
  project = var.repo_project_id
  role    = "roles/source.writer"
  member  = "serviceAccount:${module.iap_bastion.service_account}"
}

module "bastion_group" {
  source       = "terraform-google-modules/group/google"
  version      = "0.2.0"
  count        = var.create_bastion_group ? 1 : 0
  id           = var.bastion_group_id
  display_name = "bastion_group"
  description  = "bastion_group"
  domain       = split("@", var.bastion_group_id)[1]
  owners       = var.bastion_group_owners
  members      = var.bastion_members
}
