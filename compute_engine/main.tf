resource "random_id" "sa_sufix" {
  byte_length = 8
}

data "google_service_account" "existing_account" {
  count      = var.compute_service_account == "" ? 0 : 1
  account_id = var.compute_service_account
  project    = var.project_id
}

module "vm_service_account" {
  count        = var.compute_service_account == "" ? 1 : 0
  source       = "../service_account"
  account_id   = "sa-${var.sa_prefix}-${random_id.sa_sufix.dec}"
  display_name = "vm_service_account"
  description  = "Create a new service account per VM"
  project_id   = var.project_id
}

resource "google_service_account_iam_binding" "admin-account-iam" {
  count              = var.compute_service_account == "" ? 1 : 0
  service_account_id = module.vm_service_account[0].name
  role               = "roles/iam.serviceAccountUser"
  members            = ["serviceAccount:${var.terraform_service_account}"]
}

resource "google_compute_instance_iam_member" "instance_iam" {
  for_each      = toset(var.roles_list)
  project       = var.project_id
  instance_name = module.compute_instance.instances_self_links[0]
  role          = each.key
  zone          = var.zone
  member        = var.compute_service_account == "" ? "serviceAccount:${module.vm_service_account[0].email}" : "serviceAccount:${data.google_service_account.existing_account[0].email}"
}

data "google_project" "compute_project" {
  project_id = var.project_id
}

module "kms" {
  count                = var.create_key ? 1 : 0
  source               = "../kms/"
  project_id           = var.project_id
  use_existing_keyring = var.use_existing_keyring
  keyring              = var.keyring_name
  location             = var.region
  keys                 = [var.key_name]
  key_rotation_period  = var.key_rotation_period
  encrypters           = ["serviceAccount:service-${data.google_project.compute_project.number}@compute-system.iam.gserviceaccount.com"]
  set_encrypters_for   = [var.key_name]
  decrypters           = ["serviceAccount:service-${data.google_project.compute_project.number}@compute-system.iam.gserviceaccount.com"]
  set_decrypters_for   = [var.key_name]
  prevent_destroy      = var.prevent_destroy
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  count         = var.create_key ? 0 : 1
  crypto_key_id = var.disk_encryption_key
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members       = ["serviceAccount:service-${data.google_project.compute_project.number}@compute-system.iam.gserviceaccount.com"]
}

module "instance_template" {
  source      = "github.com/terraform-google-modules/terraform-google-vm/modules/instance_template"
  project_id  = var.project_id
  name_prefix = var.instance_prefix
  region      = var.region
  service_account = var.compute_service_account == "" ? ({
    email  = module.vm_service_account[0].email
    scopes = ["cloud-platform"]
    }) : ({
    email  = data.google_service_account.existing_account[0].email
    scopes = ["cloud-platform"]
  })
  can_ip_forward      = var.can_ip_forward
  disk_encryption_key = var.create_key ? module.kms[0].keys[var.key_name] : var.disk_encryption_key
  disk_size_gb        = var.disk_size_gb
  disk_type           = var.disk_type
  enable_shielded_vm  = true
  shielded_instance_config = ({
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  })
  machine_type   = var.machine_type
  source_image   = var.source_image
  startup_script = var.startup_script

  metadata = var.metadata
  labels   = var.labels
  additional_disks = [({
    disk_name    = null
    device_name  = "${var.instance_prefix}-device"
    auto_delete  = true
    boot         = false
    disk_size_gb = tonumber(var.disk_size_gb)
    disk_type    = var.disk_type
    disk_labels  = var.labels
  })]
  tags               = var.tags
  network            = var.network
  subnetwork         = var.subnetwork
  subnetwork_project = var.project_id
}

module "compute_instance" {
  source             = "github.com/terraform-google-modules/terraform-google-vm/modules/compute_instance"
  instance_template  = module.instance_template.self_link
  region             = var.region
  num_instances      = var.num_instances
  network            = var.network
  subnetwork         = var.subnetwork
  subnetwork_project = var.project_id
  zone               = var.zone
  access_config      = var.access_config
}
