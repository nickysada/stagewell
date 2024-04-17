variable "project_id" {
  description = "The Project ID to use"
  type        = string
}

variable "project_number" {
  description = "The Project Number to use"
  type        = string
}

variable "env" {
  description = "The environment to deploy to"
  type        = string
}

variable "network_endpoint_type" {
  description = "The type of Network Endpoint Group"
  type        = string
}

variable "region" {
  description = "The Region to create NEG"
  type        = string
}

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

variable "ip_cidr_range" {
  description = "IP CIDR range to use with connector"
  type        = string
}

variable "connector_name" {
  description = "The Name of connector"
  type        = string
}

variable "network_endpoint_group" {
  description = "NEG names"
  type        = map(string)
}

variable "loadbalancer_name" {
  description = "Name of the loadbalancer"
  type        = string
}

variable "managed_ssl_certificate_domains" {
  description = "Domains for the SSL certificates to be issued"
  type        = map(string)
}

variable "hostname" {
  description = "ENV value for hostname used in divdot migration job"
  type        = string
}

variable "webhook_hostname" {
  description = "ENV value for webhook_hostname used in divdot migration job"
  type        = string
}

variable "time_zone" {
  description = "Timezone for cronjobs"
  type        = string
}

variable "rabbitmq_machine_type" {
  description = "Machine type for RabbitMQ instance"
  type        = string
}

variable "rabbitmq_disk_size" {
  description = "Disk size in GB for RabbitMQ instance"
  type        = string
}

variable "bastion_machine_type" {
  description = "Machine type for Bastoin instance"
  type        = string
}

variable "bastion_disk_size" {
  description = "Disk size in GB for Bastion instance"
  type        = string
}
variable "rabbitmq_image" {
  description = "RabbitMQ image"
  type        = string
  default     = "https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.8.2/cloud-sql-proxy.linux.amd64"
}

variable "bastion_image" {
  description = "Bastion image"
  type        = string
  default     = "projects/debian-cloud/global/images/debian-10-buster-v20240213"
}
variable "retool_postgres_host" {
  description = "Rettool PostgreSQL Host"
  type        = string
}

variable "frontend_domain" {
  description = "Frontend Domain"
  type        = string
}

variable "bastion_items" {
  type        = list(map(string))
  description = "Bastion host items to specified per project and environment"
}


variable "network_name" {
  type        = string
  description = "name of the vpc network to get data from"
}

variable "enabled_service" {
  type = bool
  description = "Variable to check which service to be created in environment"
  default = true
}

variable "image_tag" {
  type = string
  description = "tag for the image being deployed"
  default = "latest"
}
