# Firestore Module

The module creates Firestore documents from the index.json file

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- App Engine Creator: `roles/appengine.appCreator`
- App Engine Deployer: `roles/appengine.deployer`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

### Usage

- Edit the json file in the jsons folder and rename the file to index.json
- Run the module with the correct permissions on the service account

## Diagram

![firestore](https://user-images.githubusercontent.com/89442747/148765601-c738b94a-1a41-4831-b732-4c0807577b82.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_firestore | Enables Datastore using the App Engine Resource | `bool` | `true` | no |
| location | App Engine Location | `string` | `"us-east1"` | no |
| project\_id | Project id where the firestore is created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| firestore\_documents | Name of the Firestore Document |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
