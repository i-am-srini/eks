<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_context\_manager\_policy\_id | The id of the default Access Context Manager policy created in step `1-org`. Can be obtained by running `gcloud access-context-manager policies list --organization YOUR_ORGANIZATION_ID --format="value(name)"`. | `number` | n/a | yes |
| default\_region1 | First subnet region. The shared vpc modules only configures two regions. | `string` | n/a | yes |
| default\_region2 | Second subnet region. The shared vpc modules only configures two regions. | `string` | n/a | yes |
| dns\_enable\_inbound\_forwarding | Toggle inbound query forwarding for VPC DNS. | `bool` | `true` | no |
| dns\_enable\_logging | Toggle DNS logging for VPC DNS. | `bool` | `true` | no |
| domain | The DNS name of peering managed zone, for instance 'example.com.'. Must end with a period. | `string` | n/a | yes |
| enable\_hub\_and\_spoke | Enable Hub-and-Spoke architecture. | `bool` | `false` | no |
| enable\_hub\_and\_spoke\_transitivity | Enable transitivity via gateway VMs on Hub-and-Spoke architecture. | `bool` | `false` | no |
| enable\_partner\_interconnect | Enable Partner Interconnect in the environment. | `bool` | `false` | no |
| firewall\_enable\_logging | Toggle firewall logging for VPC Firewalls. | `bool` | `true` | no |
| folder\_prefix | Name prefix to use for folders created. Should be the same in all steps. | `string` | `"fldr"` | no |
| nat\_bgp\_asn | BGP ASN for first NAT cloud routes. | `number` | `64514` | no |
| nat\_enabled | Toggle creation of NAT cloud router. | `bool` | `false` | no |
| nat\_num\_addresses | Number of external IPs to reserve for Cloud NAT. | `number` | `2` | no |
| nat\_num\_addresses\_region1 | Number of external IPs to reserve for first Cloud NAT. | `number` | `2` | no |
| nat\_num\_addresses\_region2 | Number of external IPs to reserve for second Cloud NAT. | `number` | `2` | no |
| optional\_fw\_rules\_enabled | Toggle creation of optional firewall rules: IAP SSH, IAP RDP and Internal & Global load balancing health check and load balancing IP ranges. | `bool` | `false` | no |
| org\_id | Organization ID | `string` | n/a | yes |
| parent\_folder | Optional - for an organization with existing projects or for development/validation. It will place all the example foundation resources under the provided folder instead of the root organization. The value is the numeric folder ID. The folder must already exist. Must be the same value used in previous step. | `string` | `""` | no |
| rules | List of custom rule definitions | <pre>list(object({<br>    name                    = string<br>    description             = string<br>    direction               = string<br>    priority                = number<br>    ranges                  = list(string)<br>    source_tags             = list(string)<br>    source_service_accounts = list(string)<br>    target_tags             = list(string)<br>    target_service_accounts = list(string)<br>    allow = list(object({<br>      protocol = string<br>      ports    = list(string)<br>    }))<br>    deny = list(object({<br>      protocol = string<br>      ports    = list(string)<br>    }))<br>    log_config = object({<br>      metadata = string<br>    })<br>  }))</pre> | `[]` | no |
| subnet\_config\_base | subnet configuration for base vpc | <pre>list(object({<br>    name   = string<br>    ip     = string<br>    region = string<br>    secondary_ranges = list(object({<br>      range_name    = string<br>      ip_cidr_range = string<br>    }))<br>  }))</pre> | `[]` | no |
| subnet\_config\_restricted | subnet configuration for restricted vpc | <pre>list(object({<br>    name   = string<br>    ip     = string<br>    region = string<br>    secondary_ranges = list(object({<br>      range_name    = string<br>      ip_cidr_range = string<br>    }))<br>  }))</pre> | `[]` | no |
| terraform\_service\_account | Service account email of the account to impersonate to run Terraform. | `string` | n/a | yes |
| windows\_activation\_enabled | Enable Windows license activation for Windows workloads. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| base\_host\_project\_id | The base host project ID |
| base\_network\_name | The name of the VPC being created |
| base\_network\_self\_link | The URI of the VPC being created |
| base\_subnets\_ips | The IPs and CIDRs of the subnets being created |
| base\_subnets\_names | The names of the subnets being created |
| base\_subnets\_secondary\_ranges | The secondary ranges associated with these subnets |
| base\_subnets\_self\_links | The self-links of subnets being created |
| restricted\_access\_level\_name | Access context manager access level name |
| restricted\_host\_project\_id | The restricted host project ID |
| restricted\_network\_name | The name of the VPC being created |
| restricted\_network\_self\_link | The URI of the VPC being created |
| restricted\_service\_perimeter\_name | Access context manager service perimeter name |
| restricted\_subnets\_ips | The IPs and CIDRs of the subnets being created |
| restricted\_subnets\_names | The names of the subnets being created |
| restricted\_subnets\_secondary\_ranges | The secondary ranges associated with these subnets |
| restricted\_subnets\_self\_links | The self-links of subnets being created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
