output "service_account" {
  description = "Service account resource (for single use)."
  value       = try(local.service_accounts_list[0], null)
}

output "email" {
  description = "Service account email (for single use)."
  value       = try(local.emails_list[0], null)
}
