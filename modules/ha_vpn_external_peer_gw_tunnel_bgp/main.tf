locals {
  secret = random_id.secret.b64_url
  peer_external_gateway = (
    var.peer_external_gateway != null
    ? google_compute_external_vpn_gateway.external_peer_vpn_gateway[0].self_link
    : null
  )
}

# ------------------------------------------------------------------------------
# FETCH SECRET FROM SECRET MANAGER
# ------------------------------------------------------------------------------

data "google_secret_manager_secret_version" "secrets" {
  count = length(var.secret_names)

   secret = var.secret_names[count.index]
}

# ------------------------------------------------------------------------------
# CREATE EXTERNAL PEER VPN GATEWAY
# ------------------------------------------------------------------------------

resource "google_compute_external_vpn_gateway" "external_peer_vpn_gateway" {
  count           = var.peer_external_gateway != null ? 1 : 0
  name            = var.peer_external_gateway.name != null ? var.peer_external_gateway.name : "${var.resource_prefix}-external-peer-gateway"
  project         = var.project_id
  redundancy_type = var.peer_external_gateway.redundancy_type
  description     = "Externally managed VPN Gateway"
 # labels          = var.labels
  dynamic "interface" {
    for_each = var.peer_external_gateway.interfaces
    content {
      id         = interface.value.id
      ip_address = interface.value.ip_address
    }
  }
}

# ------------------------------------------------------------------------------
# CREATE TUNNEL
# ------------------------------------------------------------------------------

resource "google_compute_vpn_tunnel" "tunnels" {
  for_each                        = var.tunnels
  project                         = var.project_id
  region                          = var.region
  name                            = "${var.resource_prefix}-tunnel-${each.key}"
  router                          = var.router
  vpn_gateway                     = var.vpn_gateway
  peer_external_gateway           = each.value.peer_external_gateway_self_link != null ? each.value.peer_external_gateway_self_link : local.peer_external_gateway
  peer_external_gateway_interface = each.value.peer_external_gateway_interface
  peer_gcp_gateway                = var.peer_gcp_gateway
  vpn_gateway_interface           = each.value.vpn_gateway_interface
  ike_version                     = each.value.ike_version
  shared_secret                   = data.google_secret_manager_secret_version.secrets[each.key].secret_data
}

# ------------------------------------------------------------------------------
# CREATE ROUTER INTERFACES
# ------------------------------------------------------------------------------

resource "google_compute_router_interface" "router_interface" {
  for_each   = var.tunnels
  project    = var.project_id
  region     = var.region
  name       = each.value.bgp_session_name != null ? each.value.bgp_session_name : "${var.resource_prefix}-${each.key}"
  router     = var.router
  ip_range   = each.value.bgp_session_range == "" ? null : each.value.bgp_session_range
  vpn_tunnel = google_compute_vpn_tunnel.tunnels[each.key].self_link
}

# ------------------------------------------------------------------------------
# CREATE BGP PEER SESSIONS
# ------------------------------------------------------------------------------

resource "google_compute_router_peer" "bgp_peer" {
  for_each        = var.tunnels
  region          = var.region
  project         = var.project_id
  name            = each.value.bgp_session_name != null ? each.value.bgp_session_name : "${var.resource_prefix}-bgp-session-${each.key}"
  router          = var.router
  peer_ip_address = each.value.bgp_peer.address
  peer_asn        = each.value.bgp_peer.asn
  ip_address      = each.value.bgp_peer_options == null ? null : each.value.bgp_peer_options.ip_address
  advertised_route_priority = (
    each.value.bgp_peer_options == null ? var.route_priority : (
      each.value.bgp_peer_options.route_priority == null
      ? var.route_priority
      : each.value.bgp_peer_options.route_priority
    )
  )
  advertise_mode = (
    each.value.bgp_peer_options == null ? null : each.value.bgp_peer_options.advertise_mode
  )
  advertised_groups = (
    each.value.bgp_peer_options == null ? null : (
      each.value.bgp_peer_options.advertise_mode != "CUSTOM"
      ? null
      : each.value.bgp_peer_options.advertise_groups
    )
  )
  dynamic "advertised_ip_ranges" {
    for_each = (
      each.value.bgp_peer_options == null ? {} : (
        each.value.bgp_peer_options.advertise_mode != "CUSTOM"
        ? {}
        : each.value.bgp_peer_options.advertise_ip_ranges
      )
    )
    iterator = range
    content {
      range       = range.key
      description = range.value
    }
  }
  interface = google_compute_router_interface.router_interface[each.key].name
}

resource "random_id" "secret" {
  byte_length = 8
}
