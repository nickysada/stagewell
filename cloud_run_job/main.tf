module "scheduler_service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~> 4.2"

  project_id    = var.project_id
  generate_keys = false
  prefix        = "hpoll-${var.environment}"
  names         = ["scheduler"]
  project_roles = [
    "${var.project_id}=>roles/run.invoker",
  ]
}

module "cloud_run_core" {
  source = "./job-exec"
  for_each = {
    for index, service in local.cloud_run_job :
    service.name => service
  }

  project_id        = var.project_id
  name              = each.value.name
  location          = each.value.region
  image             = each.value.image
  container_command = each.value.container_command
  sa_create         = each.value.sa_create
  sa_prefix         = local.sa_prefix
  env_secret_vars   = each.value.env_secret_vars
  env_vars          = each.value.env_vars
  limits            = each.value.limits
  argument          = each.value.argument
  volume_mounts     = each.value.volume_mounts
  volumes           = each.value.volumes
  sa_project_roles  = each.value.sa_project_roles
  schedule_sa_email = local.schedule_sa_email
  time_zone         = local.time_zone
  # scheduler_name    = each.value.scheduler_name
  schedule          = each.value.schedule
  region            = each.value.region
  vpc_access        = each.value.vpc_access
  schedule_required = each.value.schedule_required
}