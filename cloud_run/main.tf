module "serverless_project_apis" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 14.0"

  project_id                  = var.project_id
  disable_services_on_destroy = false

  activate_apis = [
    "vpcaccess.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "run.googleapis.com",
    "cloudkms.googleapis.com"
  ]
}

module "cloud_run" {
  for_each = {
    for index, service in local.cloud_run_services :
    service.service_name => service
    if service.enabled == true
  }
  ports = {
    name = each.value.name
    port = each.value.port
  }
  source                = "../modules/cloud_run"
  service_name          = each.value.service_name
  project_id            = var.project_id
  location              = var.region
  image                 = each.value.image
  service_account_email = module.cloudrun_service_account.email
  template_annotations  = each.value.template_annotations
  service_annotations   = each.value.service_annotations
  env_secret_vars       = each.value.env_secret_vars
  env_vars              = each.value.env_vars
  limits                = each.value.limits
  container_command     = each.value.container_command
  argument              = each.value.container_arg
  volume_mounts         = each.value.volume_mounts
  volumes               = each.value.volumes
  depends_on = [
    module.serverless_connector.connector,
    module.serverless_project_apis
  ]
}
