# Bastion Module

Create Bastion Host and optionally give permissions to access resources in the environment.

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- App Engine Creator: `roles/appengine.appCreator`
- App Engine Deployer: `roles/appengine.deployer`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![bastion](https://user-images.githubusercontent.com/89442747/149101031-4203666e-6fe8-4976-98fc-b8d7d45f8e55.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bastion\_group\_id | The Bastion group Email ID | `string` | `""` | no |
| bastion\_group\_owners | The bastion group owners | `list(string)` | `[]` | no |
| bastion\_members | Members to add to auto-generated service account to access bastion (Optional) | `list(string)` | `[]` | no |
| bastion\_name | The name of the bastion server | `string` | n/a | yes |
| bastion\_region | The region of the existing GCP subnetwork for bastion services | `string` | n/a | yes |
| bastion\_service\_account\_email | Email of existing service account to be used for the bastion.(optional) | `string` | `""` | no |
| bastion\_service\_account\_name | Name of new service account to be created for the bastion. | `string` | `""` | no |
| bastion\_subnet | The name of the existing GCP subnetwork for bastion services | `string` | n/a | yes |
| bastion\_subnet\_self\_link | Self link of existing Bastion Subnet (Optional) | `string` | `""` | no |
| bastion\_zone | The zone for the bastion VM | `string` | n/a | yes |
| create\_bastion\_group | Create a bastion group | `bool` | `false` | no |
| enable\_container\_access | Auto assign roles to access container clusters (Optional) | `bool` | `false` | no |
| network\_project\_id | The project id of the existing GCP subnetwork for bastion services | `string` | n/a | yes |
| other\_roles | Roles to add to auto-generated service account (Optional) | `list(string)` | `[]` | no |
| project\_id | The Google Cloud project ID | `string` | n/a | yes |
| repo\_project\_id | The project where app repos exist (optional) | `string` | `""` | no |
| vpc\_name | The name of the existing bastion VPC | `string` | n/a | yes |
| vpc\_self\_link | Self link of existing Bastion VPC(optional) | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cidr\_range | Internal IP address range of the bastion host |
| group\_email | email address of the group - ID |
| hostname | Host name of the bastion |
| ip\_address | Internal IP address of the bastion host |
| self\_link | Self link of the bastion host |
| service\_account\_email | Email address of the SA created for the bastion host |
| subnet\_name | Self link of the bastion host |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
