# Logging and Monitoring Modules

The modules create logging sink and monitoring alert policy.

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Logs Configuration Writer: `roles/logging.configWriter`
- Monitoring Admin: `roles/monitoring.admin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![logging n monitoring](https://user-images.githubusercontent.com/89442747/149098159-50af288b-dbdf-479e-816f-9ff4930405f2.png)

## Usage

- Run the module with the correct permissions on the service account

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| monitoring\_alerts | n/a | <pre>map(object({<br>    display_name           = string<br>    combiner               = string<br>    display_name_condition = string<br>    filter                 = string<br>    duration               = string<br>    comparison             = string<br>    alignment_period       = string<br>    per_series_aligner     = string<br>  }))</pre> | <pre>{<br>  "test": {<br>    "alignment_period": "60s",<br>    "combiner": "OR",<br>    "comparison": "COMPARISON_GT",<br>    "display_name": "test",<br>    "display_name_condition": "new test condition",<br>    "duration": "60s",<br>    "filter": "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\"",<br>    "per_series_aligner": "ALIGN_RATE"<br>  }<br>}</pre> | no |
| project\_id | Project id where the logging sink is created. | `string` | n/a | yes |
| sinks | logging sinks settings | <pre>map(object({<br>    name                   = string<br>    destination            = string<br>    filter                 = string<br>    unique_writer_identity = bool<br>  }))</pre> | <pre>{<br>  "my-test": {<br>    "destination": "storage.googleapis.com/testrinat",<br>    "filter": "resource.type = gcs.instance AND severity >=WARNING",<br>    "name": "my-test",<br>    "unique_writer_identity": true<br>  }<br>}</pre> | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
