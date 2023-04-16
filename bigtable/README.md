# Bigtable Module

Create a bigtable Instance in GCP

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Service Usage Consumer: `roles/serviceusage.serviceUsageConsumer`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`
- Cloud KMS Admin: `roles/cloudkms.admin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![bigtable](https://user-images.githubusercontent.com/79686242/149089913-cb8ab46a-3d75-4c95-8bb2-7dab63c9795e.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_transactional\_writes | If true, CheckAndMutateRow and ReadModifyWriteRow requests are allowed by app profile | `bool` | `true` | no |
| app\_profile\_id | The name of App Profile ID | `string` | n/a | yes |
| bigtable\_group\_id | The bigtable group id (Optional) | `string` | n/a | yes |
| bigtable\_group\_owners | The bigtable group owners (Optional) | `list(string)` | n/a | yes |
| bigtable\_member | Member to add to auto-generated service account to access bigtable (Optional) | `string` | n/a | yes |
| cluster\_configuration | Bigtable cluster configuration | <pre>object({<br>    cluster_id   = string<br>    zone         = string<br>    num_nodes    = number<br>    storage_type = string<br>  })</pre> | <pre>{<br>  "cluster_id": "",<br>  "num_nodes": 1,<br>  "storage_type": "",<br>  "zone": ""<br>}</pre> | no |
| create\_bigtable\_group | Create a bigtable group (Optional) | `bool` | n/a | yes |
| display\_name | The display name of the bigtable instance | `string` | `""` | no |
| duration | GC policy that applies to all cells older than the given age | `string` | n/a | yes |
| enable\_cmek | Enable Customer Managed Encryption Key | `bool` | `false` | no |
| family | The name of the column family | `string` | `""` | no |
| keyring\_name | Keyring name. | `string` | `"bigtable-keyring"` | no |
| labels | Define labels for an instance | `map(string)` | `{}` | no |
| location | Location for the keyring. | `string` | `""` | no |
| name | The name of the cluster | `string` | n/a | yes |
| project\_id | The name of the project id | `string` | n/a | yes |
| table\_name | The name of the table | `string` | `""` | no |
| use\_existing\_keyring | If you want to use an existing keyring and don't create a new one -> true | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| bigtable\_id | bigtable ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
