# Fortress Module

Module to create resources for Furtress Hub or Spoke Deployment

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Service Account Admin: `roles/iam.serviceAccountAdmin`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`
- Secret Manager Admin: `roles/secretmanager.admin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Architecture

![image](https://user-images.githubusercontent.com/80126401/136115530-123e3ed9-954c-4a34-886f-ffde2847e9d9.png)

## Diagram

![fortress](https://user-images.githubusercontent.com/89442747/149097926-a3cd1bd6-4ad0-455e-ba11-103e1ce15d5a.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| deployment | Hub\|Spoke\|Folder | `string` | `"spoke"` | no |
| hub\_project\_id | Fortress Hub project id. | `string` | n/a | yes |
| sa\_prefix | Fortress Spoke Folder Name. | `string` | `"slz"` | no |
| spoke\_folder\_name | Fortress Spoke Folder Name. | `string` | `""` | no |
| spoke\_project\_id | Fortress Spoke project id. | `string` | `""` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
