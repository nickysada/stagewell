locals {
  prefix = "hpoll-quest-svpc"
  connector_config = [
    {
      connector_name = "${local.prefix}-dev"
      region         = "us-central1"
      network        = "thanos" #module.helper_dev.network.network.name
      ip_cidr_range  = "10.17.8.0/28"
      hub_project_id = "rohan-orbit" #module.helper_dev.network.project_id.shared
      machine_type   = "e2-micro"
      min_instances  = 2
      max_instances  = 3
      subnet_name    = null
    },
    {
      connector_name = "${local.prefix}-stage"
      region         = "us-central1"
      network        = "thanos" #module.helper_stage.network.network.name
      ip_cidr_range  = "10.18.8.0/28"
      hub_project_id = "rohan-orbit" #module.helper_stage.network.project_id.shared
      machine_type   = "e2-micro"
      min_instances  = 2
      max_instances  = 3
      subnet_name    = nullcd
    },
     {
      connector_name = "${local.prefix}-prod" 
      region         = "us-central1"
      network        = "thanos" #module.helper_prod.network.network.name
      ip_cidr_range  = "10.19.8.0/28"
      hub_project_id = "rohan-orbit" #module.helper_prod.network.project_id.shared
      machine_type   = "e2-micro"
      min_instances  = 2     
      max_instances  = 3 
      subnet_name   = null

     }
  ]
}