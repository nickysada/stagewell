# Common Variable For HA Gateway & Cloud Router

variable "resource_prefix" {
  description = "Common prefix for Gurobi Resource"
  type = string
}

variable "project_id" {
  description = "Project where resources will be created."
  type        = string
}

variable "region" {
  description = "Region used for resources."
  type        = string
}

variable "network" {
  description = "VPC used for the gateway and routes."
  type        = string
}

# Variable For HA Gateway 

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

# Variable For Cloud Router

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

variable "router_name" {
  description = "Name of router, leave blank to create one."
  type        = string
  default     = ""
}