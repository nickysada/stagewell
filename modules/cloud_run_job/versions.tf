terraform {
  required_version = ">= 0.13"

  required_providers {
    terracurl = {
      source  = "devops-rob/terracurl"
      version = "~> 1.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "< 6"
    }
  }
  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-cloud-run:job-exec/v0.10.0"
  }
}
