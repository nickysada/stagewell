variable "project_id" {
  type = string
  description = "The Project ID to be used for deployment"
  default = "apigee-core-x"
}

variable "environment" {
  type = string
  description = "The environment for Deployment"
  default = "dev"
}