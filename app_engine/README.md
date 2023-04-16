# App Engine Module

Create App Engine in GCP

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- App Engine Creator: `roles/appengine.appCreator`
- App Engine Deployer: `roles/appengine.deployer`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.

### Usage

- First run of the module in a project must run with initialize_app set as true and service set as "default"
  - Once the default service is created it cannot be deleted without destroying the project
- Subsequent runs must run with initialize_app set as false

## Diagram

![appengine1](https://user-images.githubusercontent.com/79686242/149089159-fa29141d-81f1-4b77-b813-99b726a01c63.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| basic\_scaling | the basic scaling of the application | <pre>object({<br>    max_instances = number<br>  })</pre> | `null` | no |
| create\_app | Create App Engine Version | `bool` | `true` | no |
| database\_type | Database Type for App Engine | `string` | `"CLOUD_FIRESTORE"` | no |
| enable\_cmek | Create App Engine Version | `bool` | `false` | no |
| entrypoint | the entrypoint of the application | `string` | `""` | no |
| env\_variables | the environment variables of the application | `map` | `{}` | no |
| initialize\_app | Create App Engine Version | `bool` | `true` | no |
| labels | sorce code labels to be attached to the buckets | `map(string)` | `{}` | no |
| location | Location for app-engine and bucket | `string` | n/a | yes |
| project\_id | Project ID | `string` | n/a | yes |
| runtime | the runtime of the application | `string` | `""` | no |
| service | the name service | `string` | `"default"` | no |
| source\_code\_bucket | The bucket name of the source code of the application | `string` | `"ae-files"` | no |
| version\_id | the version id | `string` | `"v1"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
