# DataFlow Module

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Dataflow Admin: `roles/dataflow.admin`
- Service Account User: `roles/iam.serviceAccountUser`
- Storage Admin: `roles/storage.admin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![dataflow](https://user-images.githubusercontent.com/89442747/149097537-57bc378a-e434-4ac8-b05b-9dd51027176c.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_experiments | List of experiments to enable. | `list` | `[]` | no |
| create\_bucket | Create dataflow GCS bucket. | `bool` | `true` | no |
| dataflow\_bucket | Bucket name prefix. | `string` | `"dataflow-bucket"` | no |
| df\_job\_name | The name of the dataflow job | `string` | n/a | yes |
| enable\_cmek | Enable Customer Managed Encryption Key | `bool` | `false` | no |
| enable\_streaming\_engine | Enable/Disable Streaming Engine for Dataflow job. | `bool` | `false` | no |
| keyring\_name | Keyring name. | `string` | `"dataflow-keyring"` | no |
| labels | User labels to be specified for the job. | `map(string)` | `{}` | no |
| network\_project\_id | Network project ID | `string` | n/a | yes |
| parameters | Key/Value pairs to be passed to the Dataflow job (as used in the template). | `map(any)` | `{}` | no |
| project\_id | The project ID to deploy to | `string` | n/a | yes |
| region | The region in which the bucket will be deployed | `string` | n/a | yes |
| subnet\_name | Subnetwork name | `string` | n/a | yes |
| template\_gcs\_path | A writeable location on GCS for the Dataflow job to dump its temporary data. | `string` | n/a | yes |
| use\_existing\_keyring | If you want to use an existing keyring and don't create a new one -> true | `bool` | `false` | no |
| vpc\_name | VPC Network name | `string` | n/a | yes |
| zone | The zone in which the dataflow job will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_name | The name of the bucket |
| df\_job\_id | The unique Id of the newly created Dataflow job |
| df\_job\_name | The name of the newly created Dataflow job |
| df\_job\_state | The state of the newly created Dataflow job |
| project\_id | The project's ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
