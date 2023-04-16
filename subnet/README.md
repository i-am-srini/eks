# Subnet module

The module creates a subnet for specific network.
![subnet](https://user-images.githubusercontent.com/79686242/149092056-6fa113ad-328e-4b3f-bff1-5430f5c2dcf6.png)

## Usage

- Run the module with the correct permissions on the service account

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network\_name | The name of the network where subnets will be created | `any` | n/a | yes |
| project\_id | The ID of the project where subnets will be created | `any` | n/a | yes |
| secondary\_ranges | Secondary ranges that will be used in some of the subnets | <pre>map(list(object({<br>    range_name    = string,<br>    ip_cidr_range = string<br>    })<br>  ))</pre> | `{}` | no |
| service\_project | The ID of the service project that will use the Shared VPC | `string` | n/a | yes |
| subnets | The list of subnets being created | `list(map(string))` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

### Configure a Service Account
In order to execute this module you must have a Service Account with the following roles:

- Compute Network Admin: `roles/compute.networkAdmin` on the organization or folder
- Compute Shared VPC Admin: `roles/compute.xpnAdmin` on the organization and folder
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`
