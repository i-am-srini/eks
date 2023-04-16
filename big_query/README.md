# BigQuery Module

Module to create BigQuery Dataset and Tables

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- BigQuery Data Owner: `roles/bigquery.dataOwner`
- Cloud KMS Admin: `roles/cloudkms.admin`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![bigquery](https://user-images.githubusercontent.com/79686242/149089467-d5e75804-33b2-4117-b9a9-198330b63e2c.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bq\_dataset\_prefix | Prefix for dataset id. | `string` | `""` | no |
| dataset\_name | The dataset name. | `string` | n/a | yes |
| delete\_contents\_on\_destroy | If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present. | `bool` | `true` | no |
| deletion\_protection | Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply that would delete the instance will fail | `bool` | `false` | no |
| description | Description about the dataset | `string` | `""` | no |
| enable\_cmek | Enable Customer Managed Encryption Key | `bool` | `false` | no |
| key\_rotation\_period | Rotation period in seconds to be used for KMS Key | `string` | `"7776000s"` | no |
| keyring\_name | Name to be used for KMS Keyring | `string` | `"bq-keyring"` | no |
| labels | Labels provided as a map | `map(string)` | `{}` | no |
| location | Case-Sensitive Location for Big Query dataset (Should be same region as the KMS Keyring) | `string` | `"US"` | no |
| prevent\_destroy | Prevent bucket key destroy on KMS | `bool` | `true` | no |
| project\_id | Project id where the dataset and table are created. | `string` | n/a | yes |
| tables | A list of objects which include table\_id, schema, clustering, time\_partitioning, range\_partitioning, expiration\_time and labels. | <pre>list(object({<br>    table_id   = string,<br>    schema     = string,<br>    clustering = list(string),<br>    time_partitioning = object({<br>      expiration_ms            = string,<br>      field                    = string,<br>      type                     = string,<br>      require_partition_filter = bool,<br>    }),<br>    range_partitioning = object({<br>      field = string,<br>      range = object({<br>        start    = string,<br>        end      = string,<br>        interval = string,<br>      }),<br>    }),<br>    expiration_time = string,<br>    labels          = map(string),<br>  }))</pre> | `[]` | no |
| use\_existing\_keyring | If you want to use an existing keyring and don't create a new one -> true | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| bigquery\_dataset | Bigquery dataset resource. |
| table\_ids | Unique id for the tables being provisioned |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
