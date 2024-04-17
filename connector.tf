resource "google_vpc_access_connector" "connector" {
  name           = var.connector_name
  project        = var.project_id
  region         = var.region
  network        = data.google_compute_network.default.name
  min_instances  = var.min_instances
  max_instances  = var.max_instances
  ip_cidr_range  = var.ip_cidr_range
  machine_type   = var.machine_type
  max_throughput = 400
}

resource "google_compute_global_address" "external_address" {
  name         = "loadbalancer-external-ip"
  project      = var.project_id
  address_type = "EXTERNAL"
  lifecycle {
    prevent_destroy = false
  }
}

data "google_compute_network" "default" {
  name    = var.network_name
  project = var.project_id
}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.network_name
  region  = var.region
  project = var.project_id
}