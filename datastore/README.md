# DataStore Module

The module creates datastore indexes from the index.yaml file

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Cloud Datastore Owner: `roles/datastore.owner`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

## Diagram

![datastore](https://user-images.githubusercontent.com/89442747/148543872-a3560c6b-fbb1-492b-8485-18b8c470e7fb.png)

## Usage

- Edit the yaml file in the indexes folder and rename the file to index.yaml
- Run the module with the correct permissions on the service account

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_datastore | Enables Datastore using the App Engine Resource | `bool` | `true` | no |
| location | App Engine Location | `string` | `"us-east1"` | no |
| project\_id | Project id where the datastore is created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| datastore\_index\_id | ID of the Datastore Index |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
