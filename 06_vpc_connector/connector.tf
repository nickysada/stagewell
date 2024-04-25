module "serverless_connector" {
  for_each = {
    for index, connector in local.connector_config :
    connector.connector_name => connector
  }
  source = "../../vpc_connector"
  vpc_connectors = [{
    name           = each.value.connector_name
    region         = each.value.region
    network        = each.value.network
    ip_cidr_range  = each.value.ip_cidr_range
    project_id     = each.value.hub_project_id
    subnet_name    = each.value.subnet_name
    hub_project_id = each.value.hub_project_id
    machine_type   = each.value.machine_type
    min_instances  = each.value.min_instances
    max_instances  = each.value.max_instances
  }]
}

