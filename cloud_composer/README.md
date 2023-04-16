# Cloud Composer module

The module creates a Cloud Composer environment.

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Project Editor: `roles/editor`
- Network Admin: `roles/compute.networkAdmin`
- Instance Admin: `roles/compute.instanceAdmin.v1`
- Service Account User: `roles/iam.serviceAccountUser`
- Composer Worker: `roles/composer.worker`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`
- Cloud KMS Admin: `roles/cloudkms.admin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![cloud_composer](https://user-images.githubusercontent.com/89442747/149092178-7a99eaa8-c23c-4ebc-b7a2-5742790a58e1.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_composer\_subnet\_self\_link | Self link of existing composer Subnet (Optional) | `string` | `""` | no |
| composer\_config | The cloud composer configuration | <pre>map(object({<br>    composer_env_name                = string<br>    node_count                       = number<br>    machine_type                     = string<br>    use_ip_aliases                   = bool<br>    pod_ip_allocation_range_name     = string<br>    service_ip_allocation_range_name = string<br>    labels                           = map(string)<br>    disk_size                        = string<br>    oauth_scopes                     = set(string)<br>    tags                             = set(string)<br>    airflow_config_overrides         = map(string)<br>    env_variables                    = map(string)<br>    image_version                    = string<br>    pypi_packages                    = map(string)<br>    python_version                   = string<br>    cloud_sql_ipv4_cidr              = string<br>    web_server_ipv4_cidr             = string<br>    master_ipv4_cidr                 = string<br>    enable_private_endpoint          = bool<br>    kms_key_name                     = string<br>  }))</pre> | <pre>{<br>  "object": {<br>    "airflow_config_overrides": {},<br>    "cloud_sql_ipv4_cidr": null,<br>    "composer_env_name": "mycomposer-newtest",<br>    "disk_size": "100",<br>    "enable_private_endpoint": true,<br>    "env_variables": {},<br>    "image_version": null,<br>    "kms_key_name": null,<br>    "labels": {},<br>    "machine_type": "n1-standard-8",<br>    "master_ipv4_cidr": null,<br>    "node_count": 3,<br>    "oauth_scopes": [<br>      "https://www.googleapis.com/auth/cloud-platform"<br>    ],<br>    "pod_ip_allocation_range_name": null,<br>    "pypi_packages": {},<br>    "python_version": 3,<br>    "service_ip_allocation_range_name": null,<br>    "tags": [],<br>    "use_ip_aliases": true,<br>    "web_server_ipv4_cidr": null<br>  }<br>}</pre> | no |
| enable\_cmek | Enable Customer Managed Encryption Key | `bool` | `true` | no |
| key\_rotation\_period | Rotation period in seconds to be used for KMS Key | `string` | `"7776000s"` | no |
| keyring | Name to be used for KMS Keyring for CMEK | `string` | `"keyring-cloud-composer"` | no |
| network | The network id | `string` | n/a | yes |
| network\_project\_id | The project id of the existing GCP subnetwork for composer services | `string` | n/a | yes |
| prevent\_destroy | Prevent bucket key destroy on KMS | `bool` | `true` | no |
| project\_id | The resource labels (a map of key/value pairs) to be applied to the Cloud Composer. | `string` | n/a | yes |
| region | Region where the Cloud Composer Environment is created. | `string` | `"us-central1"` | no |
| service-account\_config | The service account configuration | `map(string)` | <pre>{<br>  "account_id": "newtest-cloud-composer",<br>  "description": "service account for cloud-composer",<br>  "display_name": "cloud-composer"<br>}</pre> | no |
| subnet\_name | The name of the existing GCP subnetwork for composer services | `string` | n/a | yes |
| subnetwork\_region | The subnetwork region of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| use\_existing\_keyring | If you want to use an existing keyring and don't create a new one -> true | `bool` | `false` | no |
| zone | Zone where the Cloud Composer nodes are created. | `string` | `"us-central1-f"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
