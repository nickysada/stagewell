output "gateway" {
  description = "HA VPN gateway resource."
  value       = google_compute_ha_vpn_gateway.ha_vpn_gateway
}

output "name" {
  description = "VPN gateway name."
  value       = regex("[\\w-]+$", lower(local.vpn_gateway_self_link))
}

output "self_link" {
  description = "HA VPN gateway self link."
  value       = local.vpn_gateway_self_link
}

output "router" {
  description = "Router resource (only if auto-created)."
  value       = var.router_name == "" ? google_compute_router.vpn_cloud_router[0] : null
}

output "router_name" {
  description = "Router name."
  value       = local.router
}