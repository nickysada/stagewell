locals {
  resource_prefix = "ha-gcp-aws-vpn"
}

# ------------------------------------------------------------------------------
# CREATE HA VPN GATEWAY & CLOUD ROUTER
# ------------------------------------------------------------------------------

module "ha_vpn_gateway_router" {
  source          = "../modules/ha_vpn_gw_router"
  resource_prefix = local.resource_prefix
  project_id      = var.project_id
  region          = var.region
  network         = var.network
  #stack_type      = var.stack_type

  # Create Cloud Router

  router_asn              = var.router_asn
  keepalive_interval      = var.keepalive_interval
  router_advertise_config = var.router_advertise_config
}

# ------------------------------------------------------------------------------
# CREATE EXTERNAL VPN PEER GATEWAY VPN PEER GW TUNNEL AND BGP PEERING
# ------------------------------------------------------------------------------

module "ha_vpn_peer_gw_tunnel" {
  source                = "../modules/ha_vpn_external_peer_gw_tunnel_bgp"
  peer_external_gateway = var.peer_external_gateway
  project_id            = var.project_id
  resource_prefix       = local.resource_prefix

  # CREATE HA VPN PEER GW Tunnel and BGP Peering

  tunnels      = var.tunnels
  region       = var.region
  router       = module.ha_vpn_gateway_router.router_name
  vpn_gateway  = module.ha_vpn_gateway_router.name
  secret_names = var.secret_names

}