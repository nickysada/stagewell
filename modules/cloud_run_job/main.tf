resource "google_cloud_run_v2_job" "job" {
  name         = var.name
  project      = var.project_id
  location     = var.region
  launch_stage = var.launch_stage
  labels       = var.labels

  template {
    labels      = var.labels
    parallelism = var.parallelism
    task_count  = var.task_count

    template {
      max_retries           = var.max_retries
      execution_environment = var.execution_environment
      service_account       = var.sa_create ? module.cloudrun_service_account[0].email : var.service_account_email
      timeout               = var.timeout

      containers {
        image   = var.image
        command = var.container_command
        args    = var.argument

        resources {
          limits = var.limits
        }

        dynamic "env" {
          for_each = var.env_vars
          content {
            name  = env.value["name"]
            value = env.value["value"]
          }
        }

        dynamic "env" {
          for_each = var.env_secret_vars
          content {
            name = env.value["name"]
            dynamic "value_source" {
              for_each = env.value.value_source
              content {
                secret_key_ref {
                  secret  = value_source.value.secret_key_ref["secret"]
                  version = value_source.value.secret_key_ref["version"]
                }
              }
            }
          }
        }

        dynamic "volume_mounts" {
          for_each = var.volume_mounts
          content {
            name       = volume_mounts.value["name"]
            mount_path = volume_mounts.value["mount_path"]
          }
        }
      }

      dynamic "volumes" {
        for_each = var.volumes
        content {
          name = volumes.value.name

          secret {
            secret       = volumes.value.secret
            default_mode = volumes.value.default_mode

            dynamic "items" {
              for_each = volumes.value.items
              content {
                version = items.value.version
                path    = items.value.path
                mode    = items.value.mode
              }
            }
          }
        }
      }

      dynamic "vpc_access" {
        for_each = var.vpc_access
        content {
          connector = vpc_access.value["connector"]
          egress    = vpc_access.value["egress"]
        }
      }
    }
  }
  depends_on = [module.cloudrun_service_account]
}

module "cloudrun_service_account" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 4.2"
  count         = var.sa_create ? 1 : 0
  project_id    = var.project_id
  generate_keys = false
  prefix        = var.sa_prefix
  names         = [var.name]
  project_roles = var.sa_project_roles
}

resource "google_cloud_scheduler_job" "default" {
  count     = var.schedule_required ? 1 : 0
  name      = "${var.name}-scheduler"
  schedule  = var.schedule
  project   = var.project_id
  region    = var.region
  time_zone = var.time_zone
  http_target {
    http_method = "POST"
    uri         = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project_id}/jobs/${var.name}:run"

    oauth_token {
      service_account_email = var.schedule_sa_email
    }
  }

  depends_on = [
    resource.google_cloud_run_v2_job.job
  ]
}
