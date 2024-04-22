module "cloudrun_service_account" {
  source     = "../modules/service_account"
  project_id = var.project_id
  names      = ["cr-sa"]
  prefix     = local.prefix
  project_roles = [
    "${var.project_id}=>roles/errorreporting.writer",
    "${var.project_id}=>roles/secretmanager.secretAccessor",
    "${var.project_id}=>roles/storage.admin",
    "${var.project_id}=>roles/cloudkms.cryptoKeyEncrypterDecrypter",
    "${var.project_id}=>roles/cloudsql.client",
    "${var.project_id}=>roles/run.invoker"
  ]
}
