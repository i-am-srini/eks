# Environment Baseline Module

Create a folder and provision projects and resources using Terraform.

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Organization Viewer: `roles/resourcemanager.organizationViewer`
- Folder Creator: `roles/resourcemanager.folderCreator`
- Project Creator: `roles/resourcemanager.projectCreator`
- Billing Account User: `roles/billing.user`
- Storage Admin: `roles/storage.admin`
- App Engine Creator: `roles/appengine.appCreator`
- App Engine Deployer: `roles/appengine.deployer`
- Logs Configuration Writer: `roles/logging.configWriter`
- Monitoring Admin: `roles/monitoring.admin`
- Service Account Admin: `roles/iam.serviceAccountAdmin`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`
- Secret Manager Admin: `roles/secretmanager.admin`
- Organization Policy Administrator: `roles/orgpolicy.PolicyAdmin`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![env_baseline](https://user-images.githubusercontent.com/89442747/149133476-4f83496e-78a3-4742-966a-16ab9bd797c5.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_network\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the base networks project | `string` | `null` | no |
| base\_network\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the base networks project | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| base\_network\_project\_budget\_amount | The amount to use as the budget for the base networks project | `number` | `1000` | no |
| billing\_account | The ID of the billing account to associate this project with | `string` | n/a | yes |
| billing\_code | billing\_code | `string` | `"env"` | no |
| enable\_fortress | Enable Fortress Hub\|Spoke Delpoyment | `bool` | `false` | no |
| env | The environment to prepare (ex. development) | `string` | n/a | yes |
| folder\_prefix | Name prefix to use for folders created. | `string` | `"fldr"` | no |
| fortress\_hub\_project\_id | Fortress Hub project id. (Required) | `string` | `""` | no |
| monitoring\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the monitoring project. | `string` | `null` | no |
| monitoring\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the monitoring project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| monitoring\_project\_budget\_amount | The amount to use as the budget for the monitoring project. | `number` | `1000` | no |
| monitoring\_workspace\_users | Google Workspace or Cloud Identity group that have access to Monitoring Workspaces. | `string` | n/a | yes |
| org\_id | The organization id for the associated services | `string` | n/a | yes |
| parent\_id | The parent folder or org for environments | `string` | n/a | yes |
| primary\_contact | primary\_contact | `string` | n/a | yes |
| restricted\_network\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the restricted networks project | `string` | `null` | no |
| restricted\_network\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the restricted networks project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| restricted\_network\_project\_budget\_amount | The amount to use as the budget for the restricted networks project. | `number` | `1000` | no |
| secret\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the secrets project. | `string` | `null` | no |
| secret\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the secrets project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| secret\_project\_budget\_amount | The amount to use as the budget for the secrets project. | `number` | `1000` | no |

## Outputs

| Name | Description |
|------|-------------|
| base\_shared\_vpc\_project\_id | Project for base shared VPC network. |
| env\_folder | Environment folder created under parent. |
| env\_secrets\_project\_id | Project for environment secrets. |
| monitoring\_project\_id | Project for monitoring infra. |
| restricted\_shared\_vpc\_project\_id | Project for restricted shared VPC network. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
