# Common Variables For External Peer Gateway , Tunnels & BGP Peer Sessions

variable "project_id" {
  description = "Project where resources will be created."
  type        = string
}

variable "region" {
  description = "Region used for resources."
  type        = string
}

variable "resource_prefix" {
  description = "Common prefix for Gurobi Resource"
  type = string
}

# Variables For External VPN GATEWAY

variable "peer_external_gateway" {
  description = "Configuration of an external VPN gateway to which this VPN is connected."
  type = object({
    name            = optional(string)
    redundancy_type = optional(string)
    interfaces = list(object({
      id         = number
      ip_address = string
    }))
  })
  default = null
}

# Variables For Tunnels

variable "tunnels" {
  description = "VPN tunnel configurations, bgp_peer_options is usually null."
  type = map(object({
    bgp_peer = object({
      address = string
      asn     = number
    })
    bgp_session_name = optional(string)
    bgp_peer_options = optional(object({
      ip_address          = optional(string)
      advertise_groups    = optional(list(string))
      advertise_ip_ranges = optional(map(string))
      advertise_mode      = optional(string)
      route_priority      = optional(number)
    }))
    bgp_session_range               = optional(string)
    ike_version                     = optional(number)
    vpn_gateway_interface           = optional(number)
    peer_external_gateway_self_link = optional(string, null)
    peer_external_gateway_interface = optional(number)
    shared_secret                   = optional(string)
  }))
  default = {}
}

variable "peer_gcp_gateway" {
  description = "Self Link URL of the peer side HA GCP VPN gateway to which this VPN tunnel is connected."
  type        = string
  default     = null
}


variable "route_priority" {
  description = "Route priority, defaults to 1000."
  type        = number
  default     = 1000
}

variable "secret_names" {
  type = list(string)
  description = "List of secret names to fetch"
}

 variable "router" {}
 variable "vpn_gateway" {}
 