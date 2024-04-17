module "cloud_run" {
  for_each = {
    for index, service in local.cloud_run_services :
    service.name => service
    if service.enabled == true
  }
  ports = {
    name = "http1"
    port = each.value.port
  }
  source                = "GoogleCloudPlatform/cloud-run/google"
  version               = "~> 0.10.0"
  service_name          = each.value.name
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
    resource.google_vpc_access_connector.connector,
    resource.google_compute_instance.rabbitmq_sql_bastion
  ]
}
