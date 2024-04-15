# Variable For HA Gateway

variable "project_id" {
  description = "Project where resources will be created."
  type        = string
}
variable "network" {
  description = "VPC used for the gateway and routes."
  type        = string
}
variable "region" {
  description = "Region used for resources."
  type        = string
}

variable "create_vpn_gateway" {
  description = "create a VPN gateway"
  default     = true
  type        = bool
}
variable "vpn_gateway_self_link" {
  description = "self_link of existing VPN gateway to be used for the vpn tunnel. create_vpn_gateway should be set to false"
  type        = string
  default     = null
}

# Variable for Cloud Router

variable "router_name" {
  description = "Name of router, leave blank to create one."
  type        = string
  default     = ""
}

variable "router_advertise_config" {
  description = "Router custom advertisement configuration, ip_ranges is a map of address ranges and descriptions."
  type = object({
    groups    = list(string)
    ip_ranges = map(string)
    mode      = optional(string)
  })
  default = null
}

variable "router_asn" {
  description = "Router ASN used for auto-created router."
  type        = number
  default     = 64514
}

variable "keepalive_interval" {
  description = "The interval in seconds between BGP keepalive messages that are sent to the peer."
  type        = number
  default     = 20
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

variable "external_vpn_gateway_description" {
  description = "An optional description of external VPN Gateway"
  type        = string
  default     = "Terraform managed external VPN gateway"
}

variable "tunnels" {
  description = "VPN tunnel configurations, bgp_peer_options is usually null."
  type = map(object({
    bgp_peer = object({
      address = string #AWS virtual Gateway IP
      asn     = number
    })
    bgp_session_name = optional(string)
    bgp_peer_options = optional(object({
      ip_address          = optional(string) #AWS customer Gateway IP
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
  default = {
    tunnel-0 = {
      bgp_peer = {
        address = "IP of the vpn gateway"
        asn     = 65000
      }
      bgp_peer_options = {
        ip_address          = "IP of the peer gateway that we got from aws"
        advertise_groups    = [""]
        advertise_ip_ranges = {}
        advertise_mode      = "CUSTOM"
        route_priority      = 12345
      }
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = 0
    }
  }
}
variable "secret_names" {
  type        = list(string)
  description = "List of secret names to fetch"
}
# variable "peer_gcp_gateway" {
#   description = "Self Link URL of the peer side HA GCP VPN gateway to which this VPN tunnel is connected."
#   type        = string
#   default     = null
# }
# variable "router"{}
# variable "vpn_gateway" {}