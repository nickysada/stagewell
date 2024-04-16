project_id = "rohan-orbit" # Update Project ID
#host_project_id =       # Update with project name where your vpc resides
region     = "us-central1" # Update Region
network    = "thanos"      # Update network name
router_asn = 65432         # Update Me
router_advertise_config = ({
  groups    = ["ALL_SUBNETS"]
  ip_ranges = {}
  mode      = "CUSTOM"
})
peer_external_gateway = ({
  redundancy_type = "TWO_IPS_REDUNDANCY"
  interfaces = [
    {
      id         = "0"
      ip_address = "3.212.28.112" # Update AWS Outside Virtual Gateway IP for tunnel 1
    },
    {
      id         = "1"
      ip_address = "52.73.24.202" # Update AWS Outside Virtual Gateway IP for tunnel 2
    }
  ]
})

tunnels = {
  0 = {
    bgp_peer = {
      address = "169.254.221.29" # Update AWS Inside Virtual Gateway IP for tunnel 1
      asn     = 65000
    }
    bgp_peer_options = {
      ip_address          = "169.254.221.30" # Update AWS Inside Customer Gateway IP for tunnel 1
      advertise_groups    = ["ALL_SUBNETS"]
      advertise_ip_ranges = {}
      advertise_mode      = "CUSTOM"
      route_priority      = 100
    }
    bgp_session_range               = "169.254.221.30/30"  # Update AWS Inside Customer Gateway IP for tunnel 1 with /30
    ike_version                     = 2
    vpn_gateway_interface           = 0
    peer_external_gateway_interface = 0
  }
  1 = {
    bgp_peer = {
      address = "169.254.235.81" #AWS Inside Virtual Gateway IP for tunnel 2
      asn     = 65000
    }
    bgp_peer_options = {
      ip_address          = "169.254.235.82" #AWS Inside Customer Gateway IP for tunnel 2
      advertise_groups    = ["ALL_SUBNETS"]
      advertise_ip_ranges = {}
      advertise_mode      = "CUSTOM"
      route_priority      = 100
    }
    bgp_session_range               = "169.254.235.82/30"   # Update AWS Inside Customer Gateway IP for tunnel 2 with /30
    ike_version                     = 2
    vpn_gateway_interface           = 0
    peer_external_gateway_interface = 1    
  }
}
secret_names = ["shared-key-vpn-tunnel-1", "shared-key-vpn-tunnel-2"]   # Update list of Pre-shared key secret name created in Secret Manager
