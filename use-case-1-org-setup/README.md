# Demo 1: Org Setup

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alert\_pubsub\_topic | Primary and secondary contact | `string` | `null` | no |
| alert\_spent\_percents | A list of percentages of the budget to alert on when threshold is exceeded | `list(number)` | <pre>[<br>  0.5,<br>  0.75,<br>  0.9,<br>  0.95<br>]</pre> | no |
| billing\_account | The ID of the billing account to associate projects with. | `string` | n/a | yes |
| billing\_code | Billing Code on projects | `string` | n/a | yes |
| budget\_amount | The amount to use as the budget | `number` | `1000` | no |
| contacts | Primary and secondary contact | `list(string)` | <pre>[<br>  "",<br>  ""<br>]</pre> | no |
| domain | The DNS name of peering managed zone, for instance 'example.com.' | `string` | n/a | yes |
| monitoring\_workspace\_users | Gsuite or Cloud Identity group that have access to Monitoring Workspaces. | `string` | n/a | yes |
| org\_id | GCP Organization ID | `string` | n/a | yes |
| primary\_contact | primary\_contact | `string` | n/a | yes |
| primary\_region | Primary GCP region | `string` | `"us-east1"` | no |
| scc\_notification\_name | Name of SCC Notification | `string` | n/a | yes |
| secondary\_region | Primary GCP secondary\_region | `string` | `"us-west1"` | no |
| target\_name\_server\_addresses | List of IPv4 address of target name servers for the forwarding zone configuration. See https://cloud.google.com/dns/docs/overview#dns-forwarding-zones for details on target name servers in the context of Cloud DNS forwarding zones. | `list(string)` | n/a | yes |
| terraform\_service\_account | Service account email of the account to impersonate to run Terraform. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
