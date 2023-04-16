# Pub Sub Module

Create PubSub Topis or Subscriptions

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Pub/Sub Admin: `roles/pubsub.admin`
- Cloud KMS Admin: `roles/cloudkms.admin`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![pubsub](https://user-images.githubusercontent.com/79686242/149091576-8edb4745-154f-4712-b4c5-43acd42b4922.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_topic | Specify true if you want to create a topic | `bool` | `true` | no |
| enable\_cmek | Enable Customer Managed Encryption Key | `bool` | `true` | no |
| keyring\_name | Name to be used for KMS Keyring for CMEK | `string` | `"keyring-pubsub-slz"` | no |
| location | Region for KMS and PubSub Policy | `string` | `"us-east1"` | no |
| project\_id | The project ID to manage the Pub/Sub resources | `string` | n/a | yes |
| pull\_subscriptions | The list of the pull subscriptions | <pre>list(object({<br>    name                = string<br>    additional_settings = map(string)<br>  }))</pre> | `[]` | no |
| push\_subscriptions | The list of the push subscriptions | <pre>list(object({<br>    name                = string<br>    push_endpoint       = string<br>    additional_settings = map(string)<br>  }))</pre> | `[]` | no |
| subscription\_labels | A map of labels to assign to every Pub/Sub subscription | `map(string)` | `{}` | no |
| topic\_labels | A map of labels to assign to the Pub/Sub topic | `map(string)` | `{}` | no |
| topic\_name | The name for the Pub/Sub topic | `string` | `""` | no |
| use\_existing\_keyring | If you want to use an existing keyring and don't create a new one -> true | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | The project ID |
| topic\_labels | The labels of the Pub/Sub topic created |
| topic\_name | The name of the Pub/Sub topic created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
