<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.14.0 |

## Providers

No providers.

## Modules

| Name | Source | Version | Comments |
|------|--------|---------| ---------|
| <a name="module_ha_vpn_gateway_router"></a> [ha\_vpn\_gateway\_router](#module\_ha\_vpn\_gateway\_router) | ../modules/ha_vpn_gw_router | n/a | To configure the Highly Available (HA) VPN gateway and router, first apply this module using the terraform apply -target=module.ha_vpn_gateway_router command.
| <a name="module_ha_vpn_peer_gw_tunnel"></a> [ha\_vpn\_peer\_gw\_tunnel](#module\_ha\_vpn\_peer\_gw\_tunnel) | ../modules/ha_vpn_external_peer_gw_tunnel_bgp | n/a | Run this module after the first module has completed, specifying this module as the target.


## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_vpn_gateway"></a> [create\_vpn\_gateway](#input\_create\_vpn\_gateway) | create a VPN gateway | `bool` | `true` | no |
| <a name="input_external_vpn_gateway_description"></a> [external\_vpn\_gateway\_description](#input\_external\_vpn\_gateway\_description) | An optional description of external VPN Gateway | `string` | `"Terraform managed external VPN gateway"` | no |
| <a name="input_keepalive_interval"></a> [keepalive\_interval](#input\_keepalive\_interval) | The interval in seconds between BGP keepalive messages that are sent to the peer. | `number` | `20` | no |
| <a name="input_network"></a> [network](#input\_network) | VPC used for the gateway and routes. | `string` | n/a | yes |
| <a name="input_peer_external_gateway"></a> [peer\_external\_gateway](#input\_peer\_external\_gateway) | Configuration of an external VPN gateway to which this VPN is connected. | <pre>object({<br>    name            = optional(string)<br>    redundancy_type = optional(string)<br>    interfaces = list(object({<br>      id         = number<br>      ip_address = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project where resources will be created. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region used for resources. | `string` | n/a | yes |
| <a name="input_router_advertise_config"></a> [router\_advertise\_config](#input\_router\_advertise\_config) | Router custom advertisement configuration, ip\_ranges is a map of address ranges and descriptions. | <pre>object({<br>    groups    = list(string)<br>    ip_ranges = map(string)<br>    mode      = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_router_asn"></a> [router\_asn](#input\_router\_asn) | Router ASN used for auto-created router. | `number` | `64514` | no |
| <a name="input_router_name"></a> [router\_name](#input\_router\_name) | Name of router, leave blank to create one. | `string` | `""` | no |
| <a name="input_secret_names"></a> [secret\_names](#input\_secret\_names) | List of secret names to fetch | `list(string)` | n/a | yes |
| <a name="input_tunnels"></a> [tunnels](#input\_tunnels) | VPN tunnel configurations, bgp\_peer\_options is usually null. | <pre>map(object({<br>    bgp_peer = object({<br>      address = string #AWS virtual Gateway IP<br>      asn     = number<br>    })<br>    bgp_session_name = optional(string)<br>    bgp_peer_options = optional(object({<br>      ip_address          = optional(string) #AWS customer Gateway IP<br>      advertise_groups    = optional(list(string))<br>      advertise_ip_ranges = optional(map(string))<br>      advertise_mode      = optional(string)<br>      route_priority      = optional(number)<br>    }))<br>    bgp_session_range               = optional(string)<br>    ike_version                     = optional(number)<br>    vpn_gateway_interface           = optional(number)<br>    peer_external_gateway_self_link = optional(string, null)<br>    peer_external_gateway_interface = optional(number)<br>    shared_secret                   = optional(string)<br>  }))</pre> | <pre>{<br>  "tunnel-0": {<br>    "bgp_peer": {<br>      "address": "IP of the vpn gateway",<br>      "asn": 65000<br>    },<br>    "bgp_peer_options": {<br>      "advertise_groups": [<br>        ""<br>      ],<br>      "advertise_ip_ranges": {},<br>      "advertise_mode": "CUSTOM",<br>      "ip_address": "IP of the peer gateway that we got from aws",<br>      "route_priority": 12345<br>    },<br>    "ike_version": 2,<br>    "peer_external_gateway_interface": 0,<br>    "vpn_gateway_interface": 0<br>  }<br>}</pre> | no |
| <a name="input_vpn_gateway_self_link"></a> [vpn\_gateway\_self\_link](#input\_vpn\_gateway\_self\_link) | self\_link of existing VPN gateway to be used for the vpn tunnel. create\_vpn\_gateway should be set to false | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_router_name"></a> [cloud\_router\_name](#output\_cloud\_router\_name) | The name of the Cloud Router |
| <a name="output_external_peer_gw"></a> [external\_peer\_gw](#output\_external\_peer\_gw) | External VPN gateway resource. |
| <a name="output_tunnels_name"></a> [tunnels\_name](#output\_tunnels\_name) | VPN tunnel resources names. |
| <a name="output_vpn_gw"></a> [vpn\_gw](#output\_vpn\_gw) | The name of the Gateway |
<!-- END_TF_DOCS -->