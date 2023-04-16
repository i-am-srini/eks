# Service account Module

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Service Account Admin: `roles/iam.serviceAccountAdmin`

## Diagram

![service account](https://user-images.githubusercontent.com/79686242/149091833-9e2c260e-b75c-4f94-a425-17261173e8fe.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | The service account id. | `string` | n/a | yes |
| create\_sa\_key | Set to true if a user managed key should be created for the service account | `bool` | `false` | no |
| description | The service account description. | `string` | `""` | no |
| display\_name | The service account display name. | `string` | `""` | no |
| project\_id | The ID of the project in which the service account will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| account\_id | The service account id. |
| email | The service account email. |
| id | The service account id in this format projects/{{project}}/serviceAccounts/{{email}}. |
| name | The service account name. |
| service\_account\_private\_key | Service account private key. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
