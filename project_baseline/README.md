# Project Baseline

Module to create Projects with Shared Services configuration for networking and logging.

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Folder Viewer: `roles/resourcemanager.folderViewer`
- Organization Viewer: `roles/resourcemanager.organizationViewer`
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

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![project baseline](https://user-images.githubusercontent.com/79686242/149091404-085e3ff4-2ec2-4ce0-8ee6-78a9226a496f.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| activate\_apis | The api to activate for the GCP project | `list(string)` | `[]` | no |
| billing\_account | The ID of the billing account to associated this project with | `string` | n/a | yes |
| billing\_code | The code that's used to provide chargeback information | `string` | n/a | yes |
| budget\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` | `string` | `""` | no |
| budget\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| budget\_amount | The amount to use as the budget | `number` | `1000` | no |
| cloudbuild\_sa | The Cloud Build SA used for deploying infrastructure in this project. It will impersonate the new default SA created | `string` | `""` | no |
| enable\_cloudbuild\_deploy | Enable infra deployment using Cloud Build | `bool` | `false` | no |
| enable\_firestore | Enables Datastore using the App Engine Resource | `bool` | `true` | no |
| enable\_fortress | Enable Fortress Hub\|Spoke Delpoyment | `bool` | `false` | no |
| enable\_hub\_and\_spoke | Enable Hub-and-Spoke architecture. | `bool` | `false` | no |
| environment | The environment the single project belongs to | `string` | n/a | yes |
| folder\_id | The folder id where project will be created | `string` | n/a | yes |
| fortress\_deployment | Hub\|Spoke | `string` | `"spoke"` | no |
| fortress\_hub\_project\_id | Fortress Hub project id. (Required if Spoke Deployment) | `string` | `""` | no |
| labels | Labels to be attached to the buckets | `map(string)` | `{}` | no |
| monitoring\_alerts | n/a | <pre>map(object({<br>    display_name           = string<br>    combiner               = string<br>    display_name_condition = string<br>    filter                 = string<br>    duration               = string<br>    comparison             = string<br>    alignment_period       = string<br>    per_series_aligner     = string<br>  }))</pre> | <pre>{<br>  "test": {<br>    "alignment_period": "60s",<br>    "combiner": "OR",<br>    "comparison": "COMPARISON_GT",<br>    "display_name": "test",<br>    "display_name_condition": "new test condition",<br>    "duration": "60s",<br>    "filter": "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\"",<br>    "per_series_aligner": "ALIGN_RATE"<br>  }<br>}</pre> | no |
| org\_id | The organization id for the associated services | `string` | n/a | yes |
| primary\_contact | The primary email contact for the project | `string` | `""` | no |
| project\_name | The name of the GCP project. Max 19 characters. | `string` | n/a | yes |
| project\_prefix | The prefix of the GCP project. Max 19 characters. | `string` | `""` | no |
| sa\_roles | A list of roles to give the Service Account for the project (defaults to none) | `list(string)` | `[]` | no |
| secondary\_contact | The secondary email contact for the project | `string` | `""` | no |
| sinks | logging sinks settings | <pre>map(object({<br>    name                   = string<br>    destination            = string<br>    filter                 = string<br>    unique_writer_identity = bool<br>  }))</pre> | <pre>{<br>  "my-test": {<br>    "destination": "storage.googleapis.com/testrinat",<br>    "filter": "resource.type = gcs.instance AND severity >=WARNING",<br>    "name": "my-test",<br>    "unique_writer_identity": true<br>  }<br>}</pre> | no |
| vpc\_service\_control\_attach\_enabled | Whether the project will be attached to a VPC Service Control Perimeter | `bool` | `false` | no |
| vpc\_service\_control\_perimeter\_name | The name of a VPC Service Control Perimeter to add the created project to | `string` | `null` | no |
| vpc\_type | The type of VPC to attach the project to. Possible options are base or restricted. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | Shared service project id. |
| project\_number | Project number. |
| sa | Project SA email |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
