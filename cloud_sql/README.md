# Cloud_sql Module

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Cloud SQL Admin: `roles/cloudsql.admin`
- Compute Network Admin: `roles/compute.networkAdmin`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![cloud_sql](https://user-images.githubusercontent.com/89442747/149133961-683d5ad8-5cea-47d2-9ef7-5c9b4a0efed9.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_databases | Additional Databases | <pre>list(object({<br>    name      = string<br>    charset   = string<br>    collation = string<br>  }))</pre> | `[]` | no |
| admin\_user | The admin username | `string` | `"admin"` | no |
| authorized\_networks | CIDR Ranges of Secondary IP ranges for all GKE Cluster Subnets | `list(map(string))` | n/a | yes |
| backup\_configuration | The backup\_configuration settings subblock for the database setings | <pre>object({<br>    enabled                        = bool<br>    start_time                     = string<br>    location                       = string<br>    point_in_time_recovery_enabled = bool<br>    binary_log_enabled             = bool<br>    transaction_log_retention_days = string<br>    retained_backups               = number<br>    retention_unit                 = string<br>  })</pre> | <pre>{<br>  "binary_log_enabled": true,<br>  "enabled": true,<br>  "location": null,<br>  "point_in_time_recovery_enabled": false,<br>  "retained_backups": null,<br>  "retention_unit": null,<br>  "start_time": "20:55",<br>  "transaction_log_retention_days": null<br>}</pre> | no |
| bastion\_instance\_name | The name of the bastion instance | `string` | n/a | yes |
| bastion\_service\_account\_name | The service account to be created for the bastion. | `string` | n/a | yes |
| bastion\_subnet | The name of the GCP subnetwork for bastion services | `string` | n/a | yes |
| database\_flags | The database flags for the master instance. See [more details](https://cloud.google.com/sql/docs/sqlserver/flags) | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| database\_name | The database name | `string` | n/a | yes |
| database\_type | Cloud SQL database - postgres / mysql / mssql | `string` | n/a | yes |
| database\_users | Additional Database Users | <pre>list(object({<br>    name     = string<br>    password = string<br>    host     = string<br>  }))</pre> | `[]` | no |
| database\_version | The database version | `string` | n/a | yes |
| env | The mysql database env, for deletion protection, true for prod environments and false for test environments | `string` | `"prod"` | no |
| instance\_availability\_type | The availability type for the master instance.This is only used to set up high availability for the MSSQL instance. Can be either `ZONAL` or `REGIONAL`. | `string` | n/a | yes |
| project\_id | The GCP Project ID | `string` | n/a | yes |
| region | The database/Bastion instance region | `string` | n/a | yes |
| replica\_zones | The GCP Zones | <pre>object({<br>    zone1 = string<br>    zone2 = string<br>  })</pre> | n/a | yes |
| root\_password | The Root password | `string` | `""` | no |
| shared\_vpc\_name | The name of the bastion VPC in the Shared Network Project | `string` | n/a | yes |
| shared\_vpc\_project\_id | Shared Network Project ID | `string` | n/a | yes |
| sql\_group\_id | The SQL group id | `string` | n/a | yes |
| sql\_group\_members | The SQL group members | `list(string)` | `[]` | no |
| sql\_group\_owners | The SQL group owners | `list(string)` | `[]` | no |
| sql\_instance\_prefix | The instance name prefix, random string is added as suffix | `string` | n/a | yes |
| tier | The tier for the master instance. | `string` | `"db-custom-2-13312"` | no |
| zone | The database/bastion instance zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_password\_secret | Secret id where the random password generated for root/user is stored |
| private\_ip\_address | The first private (PRIVATE) IPv4 address assigned for the master instance |
| sql\_instance\_name | The instance name for the master instance |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
