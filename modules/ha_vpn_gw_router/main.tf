locals {
  vpn_gateway_self_link = (
    var.create_vpn_gateway
    ? google_compute_ha_vpn_gateway.ha_vpn_gateway[0].self_link
    : var.vpn_gateway_self_link
  )
  router = (
    var.router_name == ""
    ? google_compute_router.vpn_cloud_router[0].name
    : var.router_name
  )
}

# ------------------------------------------------------------------------------
# CREATE HA VPN GATEWAY 
# ------------------------------------------------------------------------------

resource "google_compute_ha_vpn_gateway" "ha_vpn_gateway" {
  count      = var.create_vpn_gateway == true ? 1 : 0
  name       = "${var.resource_prefix}-gateway"
  project    = var.project_id
  region     = var.region
  network    = var.network
  # stack_type = "IPV4_ONLY"
}

# ------------------------------------------------------------------------------
# CREATE CLOUD ROUTER
# ------------------------------------------------------------------------------

resource "google_compute_router" "vpn_cloud_router" {
  count   = var.router_name == "" ? 1 : 0
  name    = "${var.resource_prefix}-router"
  project = var.project_id
  region  = var.region
  network = var.network
  bgp {
    advertise_mode = (
      var.router_advertise_config == null
      ? null
      : var.router_advertise_config.mode
    )
    advertised_groups = (
      var.router_advertise_config == null ? null : (
        var.router_advertise_config.mode != "CUSTOM"
        ? null
        : var.router_advertise_config.groups
      )
    )
    dynamic "advertised_ip_ranges" {
      for_each = (
        var.router_advertise_config == null ? {} : (
          var.router_advertise_config.mode != "CUSTOM"
          ? {}
          : var.router_advertise_config.ip_ranges
        )
      )
      iterator = range
      content {
        range       = range.key
        description = range.value
      }
    }
    asn                = var.router_asn
    keepalive_interval = var.keepalive_interval
  }
}


