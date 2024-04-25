output "cloud_run_job_id" {
  description = "The IDs of Cloud Run jobs created"
  value = {
    for k, v in module.cloud_run_core : k => v.id
  }
}

output "scheduler_sa_email" {
  description = "The email for Scheduler Service Account"
  value       = module.scheduler_service_account.email
}

output "service_account_email" {
  value = {
    for k, v in module.cloud_run_core : k => v.service_account_email
  }
}