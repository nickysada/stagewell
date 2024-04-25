locals {
     prefix    = var.prefix != "" ? "${var.prefix}-" : ""
     names                 = toset(var.names)
     service_accounts_list = [for account in google_service_account.service_accounts : account]
     emails_list           = [for account in local.service_accounts_list : account.email]
     name_role_pairs       = setproduct(local.names, toset(var.project_roles))
     project_roles_map_data = zipmap(
    [for pair in local.name_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
}

resource "google_service_account" "service_accounts" {
  for_each = local.names
  account_id   = "${local.prefix}${lower(each.value)}"
  display_name = var.display_name
  project      = var.project_id
  description  = index(var.names, each.value) >= length(var.descriptions) ? var.description : element(var.descriptions, index(var.names, each.value))
}

resource "google_project_iam_member" "project-roles" {
  for_each = local.project_roles_map_data

  project = element(
    split(
      "=>",
      each.value.role
    ),
    0,
  )

  role = element(
    split(
      "=>",
      each.value.role
    ),
    1,
  )

  member = "serviceAccount:${google_service_account.service_accounts[each.value.name].email}"
}

# keys
# resource "google_service_account_key" "keys" {
#   for_each           = var.generate_keys ? local.names : toset([])
#   service_account_id = google_service_account.service_accounts[each.value].email
# }
