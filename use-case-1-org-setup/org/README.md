# Org

This module creates shared services (e.g. centralized logging, security notification) and org level policies.

## Required Permissions

The service account running this Terraform module requires the following permissions:
* [Google Workspace Group Administrator Role](https://cloud.google.com/identity/docs/how-to/setup#auth-no-dwd) - if group emails are not provided as variable
* [Organization Policy Administrator](https://cloud.google.com/resource-manager/docs/organization-policy/using-constraints#add-org-policy-admin) - if creation of org policies is enabled
* ```roles/securitycenter.admin``` at the org level
* permissions to create folders and projects at the parent level (org level if parent is org)
* permissions to create log sync at the parent level (org level if parent is org)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| audit\_data\_users | Google Workspace or Cloud Identity group that have access to audit logs. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account. | `string` | `""` | no |
| audit\_logs\_table\_expiration\_days | Period before tables expire for all audit logs in milliseconds. Default is 30 days. | `number` | `30` | no |
| base\_net\_hub\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the base net hub project. | `string` | `null` | no |
| base\_net\_hub\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the base net hub project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| base\_net\_hub\_project\_budget\_amount | The amount to use as the budget for the base net hub project. | `number` | `1000` | no |
| billing\_account | The ID of the billing account to associate this project with | `string` | n/a | yes |
| billing\_data\_users | Google Workspace or Cloud Identity group that have access to billing data set. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account. | `string` | `""` | no |
| create\_acm\_policy | Optional - for an organization that doesn't already have google access context manager access policy. | `bool` | `false` | no |
| create\_pub\_sub | Create PubSub topic, if false topic\_name required | `bool` | `true` | no |
| data\_access\_logs\_enabled | Enable Data Access logs of types DATA\_READ, DATA\_WRITE and ADMIN\_READ for all GCP services. Enabling Data Access logs might result in your organization being charged for the additional logs usage. See https://cloud.google.com/logging/docs/audit#data-access | `bool` | `true` | no |
| default\_region | Default region for BigQuery resources. | `string` | `"us-east1"` | no |
| dns\_hub\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the DNS hub project. | `string` | `null` | no |
| dns\_hub\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the DNS hub project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| dns\_hub\_project\_budget\_amount | The amount to use as the budget for the DNS hub project. | `number` | `1000` | no |
| domain | The organization domain name | `string` | n/a | yes |
| enable\_cmek\_pubsub | Enable Customer Managed Encryption Key | `bool` | `false` | no |
| enable\_hub\_and\_spoke | Enable Hub-and-Spoke architecture. | `bool` | `true` | no |
| folder\_prefix | Name prefix to use for folders created. Should be the same in all steps. | `string` | `"fldr"` | no |
| gcs\_admin | Google Workspace or Cloud Identity group that have admin access to buckets. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account. | `string` | `""` | no |
| gcs\_write | Google Workspace or Cloud Identity group that have write access to buckets. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account. | `string` | `""` | no |
| group\_owners | Owners of all the groups created in this module. Each entry is the ID of an entity. For Google-managed entities, the ID must be the email address of an existing group, user or service account | `list(string)` | `[]` | no |
| groups | Map of groups to create or assign roles to | <pre>map(object({<br>    id           = string<br>    roles        = list(string)<br>    display_name = string<br>    description  = string<br>    create_group = bool<br>  }))</pre> | `{}` | no |
| interconnect\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the Dedicated Interconnect project. | `string` | `null` | no |
| interconnect\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the Dedicated Interconnect project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| interconnect\_project\_budget\_amount | The amount to use as the budget for the Dedicated Interconnect project. | `number` | `1000` | no |
| labels | The labels associated with this dataset. | `map(string)` | `{}` | no |
| log\_export\_storage\_location | The location of the storage bucket used to export logs. | `string` | `"US"` | no |
| log\_export\_storage\_retention\_policy | Configuration of the bucket's data retention policy for how long objects in the bucket should be retained. | <pre>object({<br>    is_locked             = bool<br>    retention_period_days = number<br>  })</pre> | `null` | no |
| log\_export\_storage\_versioning | (Optional) Toggles bucket versioning, ability to retain a non-current object version when the live object version gets replaced or deleted. | `bool` | `false` | no |
| org\_audit\_logs\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the org audit logs project. | `string` | `null` | no |
| org\_audit\_logs\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the org audit logs project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| org\_audit\_logs\_project\_budget\_amount | The amount to use as the budget for the org audit logs project. | `number` | `1000` | no |
| org\_billing\_logs\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the org billing logs project. | `string` | `null` | no |
| org\_billing\_logs\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the org billing logs project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| org\_billing\_logs\_project\_budget\_amount | The amount to use as the budget for the org billing logs project. | `number` | `1000` | no |
| org\_id | The organization id for the associated services | `string` | n/a | yes |
| org\_secrets\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the org secrets project. | `string` | `null` | no |
| org\_secrets\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the org secrets project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| org\_secrets\_project\_budget\_amount | The amount to use as the budget for the org secrets project. | `number` | `1000` | no |
| parent\_folder | Optional - for an organization with existing projects or for development/validation. It will place all the example foundation resources under the provided folder instead of the root organization. The value is the numeric folder ID. The folder must already exist. Must be the same value used in previous step. | `string` | `""` | no |
| restricted\_net\_hub\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the restricted net hub project. | `string` | `null` | no |
| restricted\_net\_hub\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the restricted net hub project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| restricted\_net\_hub\_project\_budget\_amount | The amount to use as the budget for the restricted net hub project. | `number` | `1000` | no |
| scc\_admins | Google Workspace or Cloud Identity group that have access to the org level security and command center as admin. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account. | `string` | `""` | no |
| scc\_analysts | Google Workspace or Cloud Identity group that have access to the org level security and command center as analysts. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account. | `string` | `""` | no |
| scc\_auditors | Google Workspace or Cloud Identity group that have read-only access to the org level security and command center. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account. | `string` | `""` | no |
| scc\_notification\_filter | Filter used to create the Security Command Center Notification, you can see more details on how to create filters in https://cloud.google.com/security-command-center/docs/how-to-api-filter-notifications#create-filter | `string` | `"state=\\\"ACTIVE\\\""` | no |
| scc\_notification\_name | Name of the Security Command Center Notification. It must be unique in the organization. Run `gcloud scc notifications describe <scc_notification_name> --organization=org_id` to check if it already exists. | `string` | n/a | yes |
| scc\_notifications\_project\_alert\_pubsub\_topic | The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the SCC notifications project. | `string` | `null` | no |
| scc\_notifications\_project\_alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded for the SCC notifications project. | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| scc\_notifications\_project\_budget\_amount | The amount to use as the budget for the SCC notifications project. | `number` | `1000` | no |
| secret\_admin | Google Workspace or Cloud Identity group that have access to the org level secrets as admin. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account. | `string` | `""` | no |
| secret\_analysts | Google Workspace or Cloud Identity group that have access to the org level secrets as analysts. Leaving this empty will create the group. Appropriate permissions need to be given to the Terraform service account. | `string` | `""` | no |
| skip\_gcloud\_download | Whether to skip downloading gcloud (assumes gcloud is already available outside the module. If set to true you, must ensure that Gcloud Alpha module is installed.) | `bool` | `true` | no |
| terraform\_service\_account | Service account email of the account to impersonate to run Terraform. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| access\_context\_manager\_access\_policy\_id | The storage bucket for destination of log exports |
| base\_net\_hub\_project\_id | The Base Network hub project ID |
| common\_folder\_name | The common folder name |
| dns\_hub\_project\_id | The DNS hub project ID |
| interconnect\_project\_id | The Dedicated Interconnect project ID |
| logs\_export\_pubsub\_topic | The Pub/Sub topic for destination of log exports |
| logs\_export\_storage\_bucket\_name | The storage bucket for destination of log exports |
| org\_audit\_logs\_project\_id | The org audit logs project ID |
| org\_billing\_logs\_project\_id | The org billing logs project ID |
| org\_id | The organization id |
| org\_secrets\_project\_id | The org secrets project ID |
| parent\_resource\_id | The parent resource id |
| parent\_resource\_type | The parent resource type |
| restricted\_net\_hub\_project\_id | The Restricted Network hub project ID |
| scc\_notification\_name | Name of SCC Notification |
| scc\_notifications\_project\_id | The SCC notifications project ID |
| shared\_folder | Shared folder created under parent. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
