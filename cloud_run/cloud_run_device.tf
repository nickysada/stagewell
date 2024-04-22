## Configuration for all the cloud run services to be deployed

locals {
  prefix = "quest-brand-dev"
  cloud_run_services = [
    {
      enabled           = true
      service_name      = "export-service"
      image             = "us-central1-docker.pkg.dev/${var.project_id}/${var.repo_name}/export-api:${var.image_tag}"
      container_command = []
      container_arg     = []
      service_annotations = {
        "run.googleapis.com/ingress" : "internal"
      }
      name = "http1"
      port = "8082"
      template_annotations = {
        "autoscaling.knative.dev/minScale" : 1,
        "autoscaling.knative.dev/maxScale" : 2,
        "run.googleapis.com/vpc-access-connector" : element(tolist(module.serverless_connector.connector_ids), 1),
        "generated-by" : "",
        "run.googleapis.com/client-name" : "terraform"
        "run.googleapis.com/startup-cpu-boost" : true
        "run.googleapis.com/vpc-access-egress" : "all-traffic"
        "run.googleapis.com/cpu-throttling" : ""
      }
      # Resource limits
      limits = {
        cpu    = "2"
        memory = "4000M"
      }

      ## Environment variables
      env_vars      = []
      volumes       = []
      volume_mounts = []
      env_secret_vars = [
        {
          name = "GEO_DB_DRIVER_CLASSNAME"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_driver_classname"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_PASSWORD"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_password"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_URL"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_url"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_USERNAME"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_username"
              key  = "latest"
            }
          }]
        }
      ]
    },
    {
      enabled           = true
      service_name      = "admin-service"
      image             = "us-central1-docker.pkg.dev/${var.project_id}/${var.repo_name}/admin-api:${var.image_tag}"
      container_command = []
      container_arg     = []
      service_annotations = {
        "run.googleapis.com/ingress" : "internal"
      }
      name = "http1"
      port = "8080"
      template_annotations = {
        "autoscaling.knative.dev/minScale" : 1,
        "autoscaling.knative.dev/maxScale" : 2,
        "run.googleapis.com/vpc-access-connector" : element(tolist(module.serverless_connector.connector_ids), 1),
        "generated-by" : "",
        "run.googleapis.com/client-name" : "terraform"
        "run.googleapis.com/startup-cpu-boost" : true
        "run.googleapis.com/vpc-access-egress" : "all-traffic"
        "run.googleapis.com/cpu-throttling" : ""
      }
      # Resource limits
      limits = {
        cpu    = "2"
        memory = "4000M"
      }

      ## Environment variables
      env_vars      = []
      volumes       = []
      volume_mounts = []
      env_secret_vars = [
        {
          name = "GEO_DB_DRIVER_CLASSNAME"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_driver_classname"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_PASSWORD"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_password"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_URL"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_url"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_USERNAME"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_username"
              key  = "latest"
            }
          }]
        }
      ]
    },
    {
      enabled           = true
      service_name      = "data-service"
      image             = "us-central1-docker.pkg.dev/${var.project_id}/${var.repo_name}/data-api:${var.image_tag}"
      container_command = []
      container_arg     = []
      service_annotations = {
        "run.googleapis.com/ingress" : "internal"
      }
      name = "http1"
      port = "8081"
      template_annotations = {
        "autoscaling.knative.dev/minScale" : 1,
        "autoscaling.knative.dev/maxScale" : 2,
        "run.googleapis.com/vpc-access-connector" : element(tolist(module.serverless_connector.connector_ids), 1),
        "generated-by" : "",
        "run.googleapis.com/client-name" : "terraform"
        "run.googleapis.com/startup-cpu-boost" : true
        "run.googleapis.com/vpc-access-egress" : "all-traffic"
        "run.googleapis.com/cpu-throttling" : ""
      }
      # Resource limits
      limits = {
        cpu    = "2"
        memory = "4000M"
      }

      ## Environment variables
      env_vars      = []
      volumes       = []
      volume_mounts = []
      env_secret_vars = [
        {
          name = "GEO_DB_DRIVER_CLASSNAME"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_driver_classname"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_PASSWORD"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_password"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_URL"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_url"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_USERNAME"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_username"
              key  = "latest"
            }
          }]
        }
      ]
    },
    {
      enabled           = true
      service_name      = "user-service"
      image             = "us-central1-docker.pkg.dev/${var.project_id}/${var.repo_name}/user-api:${var.image_tag}"
      container_command = []
      container_arg     = []
      service_annotations = {
        "run.googleapis.com/ingress" : "internal"
      }
      name = "http1"
      port = "8083"
      template_annotations = {
        "autoscaling.knative.dev/minScale" : 1,
        "autoscaling.knative.dev/maxScale" : 2,
        "run.googleapis.com/vpc-access-connector" : element(tolist(module.serverless_connector.connector_ids), 1),
        "generated-by" : "",
        "run.googleapis.com/client-name" : "terraform"
        "run.googleapis.com/startup-cpu-boost" : true
        "run.googleapis.com/vpc-access-egress" : "all-traffic"
        "run.googleapis.com/cpu-throttling" : ""
      }
      # Resource limits
      limits = {
        cpu    = "2"
        memory = "4000M"
      }

      ## Environment variables
      env_vars      = []
      volumes       = []
      volume_mounts = []
      env_secret_vars = [
        {
          name = "GEO_DB_DRIVER_CLASSNAME"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_driver_classname"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_PASSWORD"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_password"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_URL"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_url"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_USERNAME"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_username"
              key  = "latest"
            }
          }]
        }
      ]
    },
    {
      enabled           = true
      service_name      = "ui-service"
      image             = "us-central1-docker.pkg.dev/${var.project_id}/${var.repo_name}/ui-api:${var.image_tag}"
      container_command = []
      container_arg     = []
      service_annotations = {
        "run.googleapis.com/ingress" : "internal-and-cloud-load-balancing"
      }
      name = "http1"
      port = "3000"
      template_annotations = {
        "autoscaling.knative.dev/minScale" : 1,
        "autoscaling.knative.dev/maxScale" : 2,
        "run.googleapis.com/vpc-access-connector" : element(tolist(module.serverless_connector.connector_ids), 1),
        "generated-by" : "",
        "run.googleapis.com/client-name" : "terraform"
        "run.googleapis.com/startup-cpu-boost" : true
        "run.googleapis.com/vpc-access-egress" : "all-traffic"
        "run.googleapis.com/cpu-throttling" : ""
      }
      # Resource limits
      limits = {
        cpu    = "2"
        memory = "4000M"
      }

      ## Environment variables
      env_vars      = []
      volumes       = []
      volume_mounts = []
      env_secret_vars = [
        {
          name = "GEO_DB_DRIVER_CLASSNAME"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_driver_classname"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_PASSWORD"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_password"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_URL"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_url"
              key  = "latest"
            }
          }]
        },
        {
          name = "GEO_DB_USERNAME"
          value_from = [{
            secret_key_ref = {
              name = "geo_db_username"
              key  = "latest"
            }
          }]
        }
      ]
    }
  ]
}
