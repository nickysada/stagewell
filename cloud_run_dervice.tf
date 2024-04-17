## Configuration for all the cloud run services to be deployed

locals {
  cloud_run_services = [
    {
      enabled = true
      name              = "divdot"
      image             = "gcr.io/${var.project_id}/divdot-api:${var.image_tag}"
      container_command = ["bash", "-c"]
      container_arg     = ["python manage.py runqueue update-bank-account & python manage.py runqueue process-converge-transaction-settlement-batch & gunicorn -b 0.0.0.0:8080 api.wsgi:application --preload --timeout 0 --workers=2 --thread=4 --worker-class=gthread"]
      service_annotations = {
        "run.googleapis.com/ingress" : "internal-and-cloud-load-balancing"
      }
      port = "8080"
      template_annotations = {
        ## AUTOSCALING INSTANCES
        "autoscaling.knative.dev/maxScale" : 2,  
        "autoscaling.knative.dev/minScale" : 1,
        "run.googleapis.com/vpc-access-connector" : local.connector_id,
        "generated-by" : "terraform",
        "run.googleapis.com/client-name" : "terraform"
        "run.googleapis.com/startup-cpu-boost" : true
        "run.googleapis.com/vpc-access-egress" : "all-traffic"
        "run.googleapis.com/cpu-throttling" : "false"
      }
      # Resource limits
      limits = {
        cpu    = "4000m"
        memory = "8192M"
      }

      ## Environment variables
      env_vars = local.env_vars_template
      ## Secrets
      volumes         = []
      volume_mounts   = []
      env_secret_vars = []
    },
    {
      enabled = true
      name              = "transactions"
      image             = "gcr.io/${var.project_id}/transactions-api:${var.image_tag}"
      container_command = ["bash", "-c"]
      container_arg     = ["gunicorn -b 0.0.0.0:8080 --preload --timeout 0 api.wsgi:application"]
      service_annotations = {
        "run.googleapis.com/ingress" : "internal"
      }
      port = "8080"
      template_annotations = {
        "autoscaling.knative.dev/maxScale" : 2,
        "autoscaling.knative.dev/minScale" : 1,
        "run.googleapis.com/vpc-access-connector" : local.connector_id,
        "generated-by" : "terraform",
        "run.googleapis.com/client-name" : "terraform"
        "run.googleapis.com/startup-cpu-boost" : true
        "run.googleapis.com/vpc-access-egress" : "all-traffic"
      }

      limits = {
        cpu    = "500m"
        memory = "512Mi"
      }

      ## Environment variables
      volumes       = []
      volume_mounts = []
      env_vars = concat(
        local.env_vars_template,
      local.env_vars_template_hostname)

      ## Secrets
      env_secret_vars = []
    },
    {
      enabled = true
      name              = "ext-api-cad"
      image             = "us-central1-docker.pkg.dev/divdot-production/cloud-run-source-deploy/ext-api-cad${var.image_tag}"
      container_command = []
      container_arg     = []
      port              = "8080"
      env_vars = [
        {
          name  = "ENV"
          value = "${var.env}"
        }
      ]
      volumes         = []
      volume_mounts   = []
      env_secret_vars = []
      service_annotations = {
        "run.googleapis.com/ingress" : "all"
      }

      # Resource limits
      limits = {
        cpu    = "1000m"
        memory = "1Gi"
      }

      template_annotations = {
        "autoscaling.knative.dev/maxScale" : 2,
        "autoscaling.knative.dev/minScale" : 1,
        "run.googleapis.com/vpc-access-connector" : local.connector_id,
        "generated-by" : "terraform",
        "run.googleapis.com/client-name" : "terraform"
        "run.googleapis.com/startup-cpu-boost" : true
        "run.googleapis.com/vpc-access-egress" : "all-traffic"
      }
    },
    {
      enabled = var.enabled_service
      name              = "retool"
      image             = "tryretool/backend:2.103.7"
      container_command = ["bash", "-c"]
      container_arg     = ["./docker_scripts/wait-for-it.sh -t 0 $POSTGRES_HOST:$POSTGRES_PORT; ./docker_scripts/start_api.sh"]
      service_annotations = {
        "run.googleapis.com/ingress" : "all"
      }
      port = "3000"
      template_annotations = {
        "autoscaling.knative.dev/maxScale" : 2,
        "autoscaling.knative.dev/minScale" : 1,
        "run.googleapis.com/vpc-access-connector" : local.connector_id,
        "generated-by" : "terraform",
        "run.googleapis.com/client-name" : "terraform"
        "run.googleapis.com/startup-cpu-boost" : true
        "run.googleapis.com/vpc-access-egress" : "all-traffic"
      }

      limits = {
        cpu    = "4.0"
        memory = "8192Mi"
      }

      ## Environment variables
      volumes       = []
      volume_mounts = []
      env_vars      = local.retool_env_vars


      ## Secrets
      env_secret_vars = local.retool_env_secret_vars
    },
  ]
}