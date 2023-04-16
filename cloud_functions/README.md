# Cloud_functions Module

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Cloud Functions Developer: `roles/cloudfunctions.developer`
- Storage Admin: `roles/storage.admin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

### APIs

The project against which this module will be invoked must have the
following APIs enabled:

- Cloud Functions API: `cloudfunctions.googleapis.com`
- Cloud Storage API: `storage-component.googleapis.com`

The [Project Baseline module](../project_baseline) can be used to provision projects with specific APIs activated.

## Diagram

![cloudfunctions](https://user-images.githubusercontent.com/79686242/149090206-fdabe20a-a091-4bf0-9641-71086423bdc8.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| available\_memory\_mb | Memory (in MB), available to the function. Default value is 256. Possible values include 128, 256, 512, 1024, etc. | `number` | `128` | no |
| bucket\_name | storage bucket name that will store the code file | `string` | n/a | yes |
| create\_scheduler\_job | if cloud scheduler job is wanted need to be equal to true | `bool` | `false` | no |
| entry\_point | Name of the function that will be executed when the Google Cloud Function is triggered. | `string` | n/a | yes |
| event\_triggers | A source that fires events in response to a condition in another service. | `map(string)` | n/a | yes |
| function\_prefix | function prefix | `string` | `"trigger-function"` | no |
| invoker\_member | cloud functions function iam member with invoker role | `string` | n/a | yes |
| job\_description | Addition text to describe the job | `string` | `""` | no |
| job\_name | The name of the scheduled job to run | `string` | `null` | no |
| job\_schedule | The job frequency, in cron syntax | `string` | `"*/2 * * * *"` | no |
| keyring\_name | storage bucket keyring name | `string` | n/a | yes |
| labels | A set of key/value label pairs to assign to the function. | `map(string)` | `{}` | no |
| message\_data | The data to send in the topic message. | `string` | `"dGVzdA=="` | no |
| project\_id | cloud functions Project id. | `string` | n/a | yes |
| region | cloud functions region. | `string` | `"us-east1"` | no |
| runtime | The runtime in which the function is going to run. | `string` | `"nodejs14"` | no |
| scheduler\_http\_body | cloud scheduler http method | `string` | `null` | no |
| scheduler\_http\_method | cloud scheduler http method | `string` | `null` | no |
| storage\_bucket\_object\_source | storage bucket object source zip file with file named function.js inside | `string` | n/a | yes |
| time\_zone | The timezone to use in scheduler | `string` | `"Etc/UTC"` | no |
| topic\_name | The topic name. | `string` | `"topic-name"` | no |
| trigger\_http | Any HTTP request (of a supported type) to the endpoint will trigger function execution. Supported HTTP request types are: POST, PUT, GET, DELETE, and OPTIONS. Endpoint is returned as https\_trigger\_url. Cannot be used with event\_trigger. if it's not http trigger should be null | `bool` | `null` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
