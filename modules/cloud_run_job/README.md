# Cloud Run Job

## Description

### tagline

Deploy a Cloud Run Job and execute it.

### detailed

This module was deploys a Cloud Run Job run and executes it.

## Usage

Basic usage of this module is as follows:

```hcl
module "cloud_run_core" {
  source = "GoogleCloudPlatform/cloud-run/google//modules/secure-cloud-run-core"
  version = "~> 0.3.0"

  project_id = var.project_id
  name       = "simple-job"
  location   = "us-central1"
  image      = "us-docker.pkg.dev/cloudrun/container/job"
  exec       = true
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| argument | Arguments passed to the ENTRYPOINT command, include these only if image entrypoint needs arguments | `list(string)` | `[]` | no |
| container\_command | Leave blank to use the ENTRYPOINT command defined in the container image, include these only if image entrypoint should be overwritten | `list(string)` | `[]` | no |
| env\_secret\_vars | Environment variables (Secret Manager) | <pre>list(object({<br>    name = string<br>    value_source = set(object({<br>      secret_key_ref = object({<br>        secret  = string<br>        version = optional(string, "latest")<br>      })<br>    }))<br>  }))</pre> | `[]` | no |
| env\_vars | Environment variables (cleartext) | <pre>list(object({<br>    value = string<br>    name  = string<br>  }))</pre> | `[]` | no |
| exec | Whether to execute job after creation | `bool` | `false` | no |
| image | GCR hosted image URL to deploy | `string` | n/a | yes |
| labels | A set of key/value label pairs to assign to the Cloud Run job. | `map(string)` | `{}` | no |
| launch\_stage | The launch stage. (see https://cloud.google.com/products#product-launch-stages). Defaults to GA. | `string` | `""` | no |
| limits | Resource limits to the container | <pre>object({<br>    cpu    = optional(string)<br>    memory = optional(string)<br>  })</pre> | `null` | no |
| location | Cloud Run job deployment location | `string` | n/a | yes |
| max\_retries | Number of retries allowed per Task, before marking this Task failed. | `number` | `null` | no |
| name | The name of the Cloud Run job to create | `string` | n/a | yes |
| parallelism | Specifies the maximum desired number of tasks the execution should run at given time. Must be <= taskCount. | `number` | `null` | no |
| project\_id | The project ID to deploy to | `string` | n/a | yes |
| service\_account\_email | Service Account email needed for the job | `string` | `""` | no |
| task\_count | Specifies the desired number of tasks the execution should run. | `number` | `null` | no |
| timeout | Max allowed time duration the Task may be active before the system will actively try to mark it failed and kill associated containers. | `string` | `"600s"` | no |
| volume\_mounts | Volume to mount into the container's filesystem. | <pre>list(object({<br>    name       = string<br>    mount_path = string<br>  }))</pre> | `[]` | no |
| volumes | A list of Volumes to make available to containers. | <pre>list(object({<br>    name = string<br>    cloud_sql_instance = object({<br>      instances = set(string)<br>    })<br>  }))</pre> | `[]` | no |
| vpc\_access | VPC Access configuration to use for this Task. | <pre>list(object({<br>    connector = string<br>    egress    = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Cloud Run Job ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | < 6 |
| <a name="requirement_terracurl"></a> [terracurl](#requirement\_terracurl) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | < 6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudrun_service_account"></a> [cloudrun\_service\_account](#module\_cloudrun\_service\_account) | terraform-google-modules/service-accounts/google | ~> 4.2 |

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_v2_job.job](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_job) | resource |
| [google_cloud_scheduler_job.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_scheduler_job) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argument"></a> [argument](#input\_argument) | Arguments passed to the ENTRYPOINT command, include these only if image entrypoint needs arguments | `list(string)` | `[]` | no |
| <a name="input_container_command"></a> [container\_command](#input\_container\_command) | Leave blank to use the ENTRYPOINT command defined in the container image, include these only if image entrypoint should be overwritten | `list(string)` | `[]` | no |
| <a name="input_env_secret_vars"></a> [env\_secret\_vars](#input\_env\_secret\_vars) | Environment variables (Secret Manager) | <pre>list(object({<br>    name = string<br>    value_source = set(object({<br>      secret_key_ref = object({<br>        secret  = string<br>        version = optional(string, "latest")<br>      })<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | Environment variables (cleartext) | <pre>list(object({<br>    value = string<br>    name  = string<br>  }))</pre> | `[]` | no |
| <a name="input_execution_environment"></a> [execution\_environment](#input\_execution\_environment) | The execution environment being used to host this Task. Possible values are: EXECUTION\_ENVIRONMENT\_GEN1, EXECUTION\_ENVIRONMENT\_GEN2 | `string` | `"EXECUTION_ENVIRONMENT_GEN2"` | no |
| <a name="input_image"></a> [image](#input\_image) | GCR hosted image URL to deploy | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Cloud Run job. | `map(string)` | `{}` | no |
| <a name="input_launch_stage"></a> [launch\_stage](#input\_launch\_stage) | The launch stage. (see https://cloud.google.com/products#product-launch-stages). Defaults to GA. | `string` | `""` | no |
| <a name="input_limits"></a> [limits](#input\_limits) | Resource limits to the container | <pre>object({<br>    cpu    = optional(string)<br>    memory = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Cloud Run job deployment location | `string` | n/a | yes |
| <a name="input_max_retries"></a> [max\_retries](#input\_max\_retries) | Number of retries allowed per Task, before marking this Task failed. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cloud Run job to create | `string` | n/a | yes |
| <a name="input_parallelism"></a> [parallelism](#input\_parallelism) | Specifies the maximum desired number of tasks the execution should run at given time. Must be <= taskCount. | `number` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix applied to service account names. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy to | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Region to be used for Cloud Run Job creation | `string` | n/a | yes |
| <a name="input_sa_create"></a> [sa\_create](#input\_sa\_create) | n/a | `bool` | `false` | no |
| <a name="input_sa_project_roles"></a> [sa\_project\_roles](#input\_sa\_project\_roles) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | The Schedule to run a JOb | `string` | n/a | yes |
| <a name="input_schedule_required"></a> [schedule\_required](#input\_schedule\_required) | Check if the Cloud Run Job need to have schedule | `bool` | n/a | yes |
| <a name="input_schedule_sa_name"></a> [schedule\_sa\_name](#input\_schedule\_sa\_name) | The Service Account Name to be used with Cloud Run Scheduler | `string` | n/a | yes |
| <a name="input_scheduler_name"></a> [scheduler\_name](#input\_scheduler\_name) | Name of the Scheduler to be attached to Cloud RUn job | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Service Account email needed for the job | `string` | `""` | no |
| <a name="input_task_count"></a> [task\_count](#input\_task\_count) | Specifies the desired number of tasks the execution should run. | `number` | `null` | no |
| <a name="input_time_zone"></a> [time\_zone](#input\_time\_zone) | The time zone for Cloud Run Job scheduler/ For making sure the Job will be scheduled at appropriate timezone | `string` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Max allowed time duration the Task may be active before the system will actively try to mark it failed and kill associated containers. | `string` | `"600s"` | no |
| <a name="input_volume_mounts"></a> [volume\_mounts](#input\_volume\_mounts) | Volume to mount into the container's filesystem. | <pre>list(object({<br>    name       = string<br>    mount_path = string<br>  }))</pre> | `[]` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | n/a | <pre>list(object({<br>    name         = string<br>    secret       = string<br>    default_mode = number<br>    items = list(object({<br>      version = string<br>      path    = string<br>      mode    = number<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_vpc_access"></a> [vpc\_access](#input\_vpc\_access) | VPC Access configuration to use for this Task. | <pre>list(object({<br>    connector = string<br>    egress    = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Cloud Run Job ID |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | n/a |
<!-- END_TF_DOCS -->