module "cloudrun_service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~> 4.2"

  project_id    = var.project_id
  generate_keys = false
  prefix        = "secure-access"
  names         = ["cloudrun"]
  project_roles = [
    "${var.project_id}=>roles/errorreporting.writer",
    "${var.project_id}=>roles/secretmanager.secretAccessor",
    "${var.project_id}=>roles/storage.admin",
    "${var.project_id}=>roles/cloudkms.cryptoKeyEncrypterDecrypter",
    "${var.project_id}=>roles/cloudsql.client",
    "${var.project_id}=>roles/run.invoker"
  ]
}
