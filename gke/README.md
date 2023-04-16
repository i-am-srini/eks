# GKE Module

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Compute Viewer: `roles/compute.viewer`
- Compute Security Admin: `roles/compute.securityAdmin`
- Kubernetes Engine Cluster Admin: `roles/container.clusterAdmin`
- Service Account Admin: `roles/iam.serviceAccountAdmin`
- Service Account User: `roles/iam.serviceAccountUser`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![gke](https://user-images.githubusercontent.com/79686242/149090889-9d9b01a4-b96f-4270-893d-8b1908cc4f32.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowlist\_patterns | The google binary authorization policy allowlist patterns | `list(string)` | <pre>[<br>  "quay.io/random-containers/*",<br>  "k8s.gcr.io/more-random/*",<br>  "gcr.io/config-management-release/*"<br>]</pre> | no |
| attestors\_keyring\_id | The attestors keyring id | `string` | n/a | yes |
| bastion\_name | The zone for the bastion VM in primary region. | `string` | `"bastion-gke"` | no |
| bastion\_region | The zone for the bastion VM in primary region. | `string` | `"us-west1"` | no |
| bastion\_service\_account\_email | The bastion service account email | `string` | n/a | yes |
| bastion\_subnet\_name | The name of the subnet for the shared VPC. | `string` | `"bastion-host-subnet"` | no |
| bastion\_zone | The zone for the bastion VM in primary region. | `string` | `"us-west1-b"` | no |
| bin\_auth\_attestor\_names | Binary Authorization Attestor Names set up in shared app\_cicd project. | `list(string)` | n/a | yes |
| create\_bastion | Create bastion -optional. | `bool` | `false` | no |
| enforce\_bin\_auth\_policy | Enable or Disable creation of binary authorization policy. | `bool` | `false` | no |
| gke\_settings | Map of all the clusters configurations | <pre>map(object({<br>    name                      = string<br>    subnetwork                = string<br>    ip_range_pods             = string<br>    ip_range_services         = string<br>    master_ipv4_cidr_block    = string<br>    enable_external_ip        = bool<br>    default_max_pods_per_node = number<br>    region                    = string<br>    node_pool_min_count       = number<br>    node_pool_max_count       = number<br>    machine_type              = string<br>    master_authorized_networks = list(object({<br>      cidr_block   = string<br>      display_name = string<br>    }))<br>  }))</pre> | `{}` | no |
| project\_id | The project ID to host the cluster in (required) | `string` | n/a | yes |
| shared\_vpc\_name | The shared VPC network name. | `string` | n/a | yes |
| shared\_vpc\_project\_id | The shared VPC network project id. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
