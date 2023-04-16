module "subnet" {
  source           = "terraform-google-modules/network/google//modules/subnets"
  project_id       = var.project_id
  network_name     = var.network_name
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = var.project_id
}

resource "google_compute_shared_vpc_service_project" "service" {
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = var.service_project
}

data "google_project" "subnet_project" {
  project_id = var.project_id
}

resource "google_compute_subnetwork_iam_member" "memner-policy" {
  depends_on = [
    module.subnet.subnets
  ]
  project    = var.project_id
  for_each   = { for subnet in var.subnets : subnet.subnet_name => subnet }
  region     = each.value.subnet_region
  subnetwork = each.value.subnet_name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${data.google_project.subnet_project.number}@cloudservices.gserviceaccount.com"
}
