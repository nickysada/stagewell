<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_run_core"></a> [cloud\_run\_core](#module\_cloud\_run\_core) | ./job-exec | n/a |
| <a name="module_scheduler_service_account"></a> [scheduler\_service\_account](#module\_scheduler\_service\_account) | terraform-google-modules/service-accounts/google | ~> 4.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for Deployment | `string` | `"dev"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The Project ID to be used for deployment | `string` | `"apigee-core-x"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_run_job_id"></a> [cloud\_run\_job\_id](#output\_cloud\_run\_job\_id) | The IDs of Cloud Run jobs created |
| <a name="output_scheduler_sa_email"></a> [scheduler\_sa\_email](#output\_scheduler\_sa\_email) | The email for Scheduler Service Account |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | n/a |
<!-- END_TF_DOCS -->