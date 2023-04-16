locals {
  attestors = [for attestor_name in var.bin_auth_attestor_names : module.attestors[attestor_name].attestor]
}

module "gke_bastion" {
  count                         = var.create_bastion ? 1 : 0
  source                        = "../bastion"
  project_id                    = var.project_id
  bastion_region                = var.bastion_region
  bastion_subnet                = var.bastion_subnet_name
  network_project_id            = var.shared_vpc_project_id
  vpc_name                      = var.shared_vpc_name
  bastion_name                  = var.bastion_name
  bastion_zone                  = var.bastion_zone
  bastion_service_account_email = var.bastion_service_account_email
  enable_container_access       = true
}

data "google_project" "gke_project" {
  project_id = var.project_id
}

module "clusters" {
  source   = "terraform-google-modules/kubernetes-engine/google//modules/safer-cluster"
  version  = "~> 16.1.0"
  for_each = var.gke_settings

  project_id                = var.project_id
  network_project_id        = var.shared_vpc_project_id
  network                   = var.shared_vpc_name
  name                      = each.value.name
  subnetwork                = each.value.subnetwork
  ip_range_pods             = each.value.ip_range_pods
  ip_range_services         = each.value.ip_range_services
  master_ipv4_cidr_block    = each.value.master_ipv4_cidr_block
  default_max_pods_per_node = each.value.default_max_pods_per_node
  region                    = each.value.region
  master_authorized_networks = var.create_bastion ? concat(each.value.master_authorized_networks,
    [
      {
        cidr_block   = module.gke_bastion.cidr_range,
        display_name = "bastion subnet to cluster controlplane"
      }
    ]
  ) : each.value.master_authorized_networks
  cluster_resource_labels = {
    "mesh_id" = "proj-${data.google_project.gke_project.number}"
  }
  node_pools_tags = {
    "np-${each.value.region}" : ["boa-${each.key}-cluster", "allow-google-apis", "egress-internet", "boa-cluster", "allow-lb"]
  }
  node_pools = [
    {
      name               = "np-${each.value.region}",
      auto_repair        = true,
      auto_upgrade       = true,
      enable_secure_boot = true,
      image_type         = "COS_CONTAINERD",
      machine_type       = each.value.machine_type,
      max_count          = each.value.node_pool_max_count,
      min_count          = each.value.node_pool_min_count,
      node_metadata      = "GKE_METADATA_SERVER"
    }
  ]
  node_pools_oauth_scopes = {
    "all" : [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ],
    "default-node-pool" : []
  }
  compute_engine_service_account = var.bastion_service_account_email
}

module "attestors" {
  source   = "terraform-google-modules/kubernetes-engine/google//modules/binary-authorization"
  version  = "~> 14.1"
  for_each = toset(var.bin_auth_attestor_names)

  project_id    = var.project_id
  attestor-name = each.key
  keyring-id    = var.attestors_keyring_id
}

resource "google_binary_authorization_policy" "policy" {
  project = var.project_id

  global_policy_evaluation_mode = "ENABLE"
  default_admission_rule {
    evaluation_mode         = "REQUIRE_ATTESTATION"
    enforcement_mode        = var.enforce_bin_auth_policy ? "ENFORCED_BLOCK_AND_AUDIT_LOG" : "DRYRUN_AUDIT_LOG_ONLY"
    require_attestations_by = local.attestors
  }
  dynamic "admission_whitelist_patterns" {
    for_each = concat(var.allowlist_patterns, ["gcr.io/${var.project_id}/*"])
    content {
      name_pattern = join(", ", local.attestors)
    }
  }
}

/******************************************
 Cloud Armor policy
*****************************************/

resource "google_compute_security_policy" "cloud-armor-xss-policy" {
  name    = "cloud-armor-xss-policy"
  project = var.project_id
  rule {
    action   = "deny(403)"
    priority = "1000"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('xss-stable')"
      }
    }
    description = "Cloud Armor policy to prevent cross-site scripting attacks."
  }

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}

/******************************************
 External IP Address
*****************************************/

resource "google_compute_global_address" "external_ip_for_http_load_balancing" {
  for_each     = { for cluster, cluster_settings in var.gke_settings : cluster => cluster_settings if cluster_settings.enable_external_ip }
  name         = "${each.value.name}-ip"
  project      = var.project_id
  address_type = "EXTERNAL"
  description  = "External IP address for ${each.value.name} cluster"
}
