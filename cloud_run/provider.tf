provider "google" {
  version = "4.14.0" # see https://github.com/terraform-providers/terraform-provider-google/releases
  project = var.project_id
  #  region  = var.region
  #  zone    = var.zone
}
