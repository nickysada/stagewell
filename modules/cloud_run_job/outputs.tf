output "id" {
  description = "Cloud Run Job ID"
  value       = google_cloud_run_v2_job.job.id
}

output "service_account_email" {
  value = {
    for k, v in module.cloudrun_service_account : k => v.email
  }
}