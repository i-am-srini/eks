# Policies Module

This module deploys organization policy json files.

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Organization Policy Administrator: `roles/orgpolicy.PolicyAdmin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![policies](https://user-images.githubusercontent.com/89442747/149098535-498d3264-c116-4d9f-95c6-b639eb8f2e5a.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | policies environment polder: dev, prod or nonprod | `string` | `"prod"` | no |
| folder\_id | Optional - the folder to apply the set of policies to. If organization\_id is not empty, the policies will be applied at the organization level. | `string` | `""` | no |
| org\_id | Optional - the organization id to apply the set of policies to. | `string` | `""` | no |
| project\_id | Optional - the project to apply the set of policies to. If organization\_id or folder\_id are not empty, the policies will be applied at organization or folder level. | `string` | `""` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
