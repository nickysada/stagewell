locals {
  sa_prefix = "hpoll-${var.environment}-run"
  time_zone      = "Etc/UTC"
  schedule_sa_email = module.scheduler_service_account.email

  cloud_run_job = [
    {
      name              = "test"
      region            = "us-central1"
      image             = "us-docker.pkg.dev/cloudrun/container/job"
      container_command = ["python", "manage.py", "migrate"]
      argument          = []

      # Resource limits Section
      limits = {
        cpu    = "1000m"
        memory = "1Gi"
      }
      ### Volume Section 
      volumes = [
        {
          name         = "a-volume"
          secret       = "test"
          default_mode = 292 # 0444
          items = [
            {
              version = "1"
              path    = "my-secret"
              mode    = 256 # 0400
            }
          ]
        }
      ]
      ### Volume Mounte Section 
      volume_mounts = [{
        name       = "a-volume"
        mount_path = "/tmp"
        }
      ]
      ### VPC Connector Section 
      vpc_access = [
        {
          connector = "projects/${var.project_id}/locations/us-central1/connectors/cloudrun-job"
          egress    = "ALL_TRAFFIC"
        },
      ]
      # Environment variables Section 
      env_vars = [
        {
          value = "string"
          name  = "string"
        }
      ]
      # Secrets Section
      env_secret_vars = [{
        name = "POSTGRES_PASSWORD"
        value_source = [
          {
            secret_key_ref = {
              secret = "test"
              key    = "latest"
            }
          }
        ]
      }, ]

      ##### Scheduler Section 
      schedule_required = true
      # scheduler_name    = "test"
      schedule          = "0 16 * * *"
      ##### Service Account Section
      sa_create = true
      sa_project_roles = [
        "${var.project_id}=>roles/secretmanager.secretAccessor",
      ]
    },

    {
      name           = "test1"
      # scheduler_name = "test1"
      schedule       = "0 16 1 * *"
      region         = "us-central1"
      sa_create      = true
      schedule_required = true
      sa_project_roles = [
        "${var.project_id}=>roles/errorreporting.writer",
        "${var.project_id}=>roles/secretmanager.secretAccessor",
      ]
      image = "us-docker.pkg.dev/cloudrun/container/job"
      container_command = [
        "python", "manage.py", "migrate"
      ]
      argument = []
      # Resource limits
      limits = {
        cpu    = "1000m"
        memory = "1Gi"
      }


      volumes       = []
      volume_mounts = []
      # connector = "cloudrun-job"
      vpc_access = [
        {
          connector = "projects/${var.project_id}/locations/us-central1/connectors/cloudrun-job"
          egress    = "ALL_TRAFFIC"
        },
      ]
      # Environment variables
      env_vars = [
        {
          value = "string"
          name  = "string"
        }
      ]
      # Secrets
      env_secret_vars = [
        {
          name = "POSTGRES_PASSWORD"
          value_source = [
            {
              secret_key_ref = {
                secret = "test"
                key    = "latest"
              }
            }
          ]
        },
      ]
    },
  ]
}


