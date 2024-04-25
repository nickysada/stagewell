variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "name" {
  description = "The name of the Cloud Run job to create"
  type        = string
}

variable "location" {
  description = "Cloud Run job deployment location"
  type        = string
}

variable "image" {
  description = "GCR hosted image URL to deploy"
  type        = string
}

variable "service_account_email" {
  type        = string
  description = "Service Account email needed for the job"
  default     = ""
}

variable "argument" {
  type        = list(string)
  description = "Arguments passed to the ENTRYPOINT command, include these only if image entrypoint needs arguments"
  default     = []
}

variable "container_command" {
  type        = list(string)
  description = "Leave blank to use the ENTRYPOINT command defined in the container image, include these only if image entrypoint should be overwritten"
  default     = []
}

variable "env_vars" {
  type = list(object({
    value = string
    name  = string
  }))
  description = "Environment variables (cleartext)"
  default     = []
}

variable "env_secret_vars" {
  type = list(object({
    name = string
    value_source = set(object({
      secret_key_ref = object({
        secret  = string
        version = optional(string, "latest")
      })
    }))
  }))
  description = "Environment variables (Secret Manager)"
  default     = []
}

variable "launch_stage" {
  type        = string
  description = "The launch stage. (see https://cloud.google.com/products#product-launch-stages). Defaults to GA."
  default     = ""
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "A set of key/value label pairs to assign to the Cloud Run job."
}

variable "max_retries" {
  type        = number
  default     = null
  description = "Number of retries allowed per Task, before marking this Task failed."
}

variable "parallelism" {
  type        = number
  default     = null
  description = "Specifies the maximum desired number of tasks the execution should run at given time. Must be <= taskCount."
}

variable "task_count" {
  type        = number
  default     = null
  description = "Specifies the desired number of tasks the execution should run."
}

variable "volumes" {
  type = list(object({
    name         = string
    secret       = string
    default_mode = number
    items = list(object({
      version = string
      path    = string
      mode    = number
    }))
  }))
}

# variable "volumes" {
#   type = list(object({
#     name = string
#     cloud_sql_instance = object({
#       instances = set(string)
#     })
#   }))
#   description = "A list of Volumes to make available to containers."
#   default     = []
# }

variable "volume_mounts" {
  type = list(object({
    name       = string
    mount_path = string
  }))
  description = "Volume to mount into the container's filesystem."
  default     = []
}

variable "vpc_access" {
  type = list(object({
    connector = string
    egress    = string
  }))
  description = "VPC Access configuration to use for this Task."
  default     = []
}

variable "limits" {
  type = object({
    cpu    = optional(string)
    memory = optional(string)
  })
  description = "Resource limits to the container"
  default     = null
}

variable "timeout" {
  type        = string
  description = "Max allowed time duration the Task may be active before the system will actively try to mark it failed and kill associated containers."
  default     = "600s"
  validation {
    condition     = can(regex("^[0-9]+(\\.[0-9]{1,9})?s$", var.timeout))
    error_message = "The value must be a duration in seconds with up to nine fractional digits, ending with 's'. Example: \"3.5s\"."
  }
}

variable "execution_environment" {
  type        = string
  description = "The execution environment being used to host this Task. Possible values are: EXECUTION_ENVIRONMENT_GEN1, EXECUTION_ENVIRONMENT_GEN2"
  default     = "EXECUTION_ENVIRONMENT_GEN2"
}

variable "sa_create" {
  type    = bool
  default = false
}

variable "sa_project_roles" {
  type    = list(string)
  default = [""]

}

variable "sa_prefix" {
  type        = string
  description = "Prefix applied to service account names."
}

variable "schedule_required" {
  type        = bool
  description = "Check if the Cloud Run Job need to have schedule"
}

variable "schedule" {
  type        = string
  description = "The Schedule to run a JOb"
}

variable "region" {
  type        = string
  description = "The Region to be used for Cloud Run Job creation"
}

variable "time_zone" {
  type        = string
  description = "The time zone for Cloud Run Job scheduler/ For making sure the Job will be scheduled at appropriate timezone"
}

variable "schedule_sa_email" {
  type        = string
  description = "The Service Account Name to be used with Cloud Run Scheduler"
}