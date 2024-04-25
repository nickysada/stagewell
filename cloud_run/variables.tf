
# Common Variable

variable "project_id" {
  description = "The Project ID to where resource has to created"
  type        = string
}

# variable "hub_project_id" {
#   description = "The Project ID where network exist"
#   type        = string
# }

variable "env" {
  description = "The environment to deploy to"
  type        = string
}

variable "region" {
  description = "The Region to create NEG"
  type        = string
}



# Variable for service

variable "enabled_service" {
  type        = bool
  description = "Variable to check which service to be created in environment"
  default     = true
}

variable "image_tag" {
  type        = string
  description = "tag for the image being deployed"
  default     = "latest"
}

variable "repo_name" {
  type        = string
  description = "artifact registry name "
  default     = "latest"
}


# Variable For VPC Connector

variable "min_instances" {
  description = "Minimum number of instances to create"
  type        = number
}

variable "max_instances" {
  description = "Maximum number of instances to create"
  type        = number
}

variable "machine_type" {
  description = "The machine type to use for Connector"
  type        = string
}

variable "ip_cidr_range" {}


