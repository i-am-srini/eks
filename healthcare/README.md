# Healthcare Module

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Healthcare Dataset Admin: `roles/healthcare.datasetAdmin`
- Healthcare DICOM Admin: `roles/healthcare.dicomStoreAdmin`
- Healthcare FHIR Admin: `roles/healthcare.fhirStoreAdmin`
- Healthcare HL7 V2 Admin: `roles/healthcare.hl7V2StoreAdmin`
- Healthcare Consent Admin: `roles/healthcare.ConsentStoreAdmin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the resources of this module:

- Google Cloud Healthcare API: `healthcare.googleapis.com`
- Google Pub/Sub API: `pubsub.googleapis.com`

The [Project Baseline module](../project_baseline) can be used to provision a project with the necessary APIs enabled.

## Diagram

![healthcare](https://user-images.githubusercontent.com/79686242/149091239-0e19729a-eadf-4a71-a032-a26acfd3dc2b.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| consent\_stores | Datastore that contain all information related to the configuration and operation of the Consent Management API (https://cloud.google.com/healthcare/docs/how-tos/consent-managing). | `any` | `[]` | no |
| create\_big\_query | Create BigQuery, if false dataset\_id and table\_id required | `bool` | `true` | no |
| create\_pub\_sub | Create BigQuery, if false topic\_name required | `bool` | `true` | no |
| dataset\_id | The ID of the bigquery dataset. | `string` | `""` | no |
| dataset\_name | The dataset name. | `string` | `""` | no |
| dicom\_stores | Datastore that conforms to the DICOM (https://www.dicomstandard.org/about/) standard for Healthcare information exchange. | `any` | `[]` | no |
| enable\_cmek | Enable Customer Managed Encryption Key | `bool` | `false` | no |
| fhir\_stores | Datastore that conforms to the FHIR standard for Healthcare information exchange. | `any` | `[]` | no |
| healthcare\_location | The location for the Dataset. | `string` | n/a | yes |
| healthcare\_name | The resource name for the Dataset. | `string` | n/a | yes |
| healthcare\_sa | The healthcare service account. | `string` | `""` | no |
| hl7\_v2\_stores | Datastore that conforms to the HL7 V2 (https://www.hl7.org/hl7V2/STU3/) standard for Healthcare information exchange. | `any` | `[]` | no |
| iam\_members | Updates the IAM policy to grant a role to a new member. Other members for the role for the dataset are preserved. | <pre>list(object({<br>    role   = string<br>    member = string<br>  }))</pre> | `[]` | no |
| project\_id | The ID of the project in which the resource belongs. | `string` | n/a | yes |
| table\_id | The ID of the bigquery table. | `string` | `""` | no |
| tables | A list of objects which include table\_id, schema, clustering, time\_partitioning, range\_partitioning, expiration\_time and labels. | <pre>list(object({<br>    table_id   = string,<br>    schema     = string,<br>    clustering = list(string),<br>    time_partitioning = object({<br>      expiration_ms            = string,<br>      field                    = string,<br>      type                     = string,<br>      require_partition_filter = bool,<br>    }),<br>    range_partitioning = object({<br>      field = string,<br>      range = object({<br>        start    = string,<br>        end      = string,<br>        interval = string,<br>      }),<br>    }),<br>    expiration_time = string,<br>    labels          = map(string),<br>  }))</pre> | `[]` | no |
| topic\_name | The ID of the bigquery dataset. | `string` | `""` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
