## need to move this code in client ne

data "google_compute_network" "network" {
  name    = var.dev_network_name
  project = var.project_id
}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.dev_subnetwork_name
  region  = var.region
  project = var.project_id
}

module "serverless_connector" {
  source     = "../modules/vpc_connector"
  project_id = var.project_id
  vpc_connectors = [{
    name   = "${local.prefix}-svc"
    region = var.region
    network         = data.google_compute_network.network.name
    ip_cidr_range   = var.ip_cidr_range
    #subnet_name    = data.google_compute_subnetwork.subnetwork.name
    hub_project_id = var.hub_project_id
    machine_type   = var.machine_type
    min_instances  = var.min_instances
    max_instances  = var.max_instances
  }]
}
