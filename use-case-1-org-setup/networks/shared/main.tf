locals {
  parent_id        = var.parent_folder != "" ? "folders/${var.parent_folder}" : "organizations/${var.org_id}"
  env              = "common"
  environment_code = "c"
  bgp_asn_number   = var.enable_partner_interconnect ? "16550" : "64514"
}

data "google_active_folder" "common" {
  display_name = "${var.folder_prefix}-${local.env}"
  parent       = local.parent_id
}
