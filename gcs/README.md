# GCS Module

Module to create one or more secure GCS Buckets

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Storage Admin: `roles/storage.admin`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`
- Cloud KMS Admin: `roles/cloudkms.admin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![gcs](https://user-images.githubusercontent.com/79686242/149090577-a986b162-900c-4aca-b159-4d446d77c36d.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_location | Bucket location | `string` | n/a | yes |
| enable\_cmek | Enable Customer Managed Encryption Key | `bool` | `true` | no |
| gcs\_admin\_group\_id | The gcs admin group id that will be connected to the buckets | `string` | `""` | no |
| gcs\_write\_group\_id | The gcs write group id that will be connected to the buckets | `string` | `""` | no |
| key\_rotation\_period | Rotation period in seconds to be used for KMS Key | `string` | `"7776000s"` | no |
| keyring\_name | Name to be used for KMS Keyring for CMEK | `string` | `"keyring-gcs_buckets"` | no |
| labels | Labels to be attached to the buckets | `map(string)` | `{}` | no |
| lifecycle\_rules | List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches\_storage\_class should be a comma delimited string. | <pre>set(object({<br>    action    = map(string)<br>    condition = map(string)<br>  }))</pre> | <pre>[<br>  {<br>    "action": {<br>      "type": "Delete"<br>    },<br>    "condition": {<br>      "age": 3<br>    }<br>  }<br>]</pre> | no |
| names | Bucket name suffixes. | `list(string)` | `[]` | no |
| prefix | Prefix used to generate the bucket name | `string` | `""` | no |
| prevent\_destroy | Prevent bucket key destroy on KMS | `bool` | `true` | no |
| project\_id | Bucket project id. | `string` | n/a | yes |
| storage\_class | Storage class. | `string` | `"MULTI_REGIONAL"` | no |
| use\_existing\_keyring | If you want to use an existing keyring and don't create a new one -> true | `bool` | `false` | no |
| versioning | Versioning of the buckets | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket | Bucket resource (for single use). |
| buckets | Bucket resources as list. |
| name | Bucket name (for single use). |
| names | Bucket names. |
| names\_list | List of bucket names. |
| url | Bucket URL (for single use). |
| urls | Bucket URLs. |
| urls\_list | List of bucket URLs. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
