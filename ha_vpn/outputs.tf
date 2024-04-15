output "vpn_gw" {
  description = "The name of the Gateway"
  value       = module.ha_vpn_gateway_router.gateway
}

output "cloud_router_name" {
  description = "The name of the Cloud Router"
  value       = module.ha_vpn_gateway_router.router_name
}

output "tunnels_name" {
  description = "VPN tunnel resources names."
  value = module.ha_vpn_peer_gw_tunnel.tunnel_names
}

output "external_peer_gw" {
  description = "External VPN gateway resource."
  value       = module.ha_vpn_peer_gw_tunnel.external_gateway
}

