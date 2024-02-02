resource "google_service_account" "vault" {
  account_id   = "vault-service-account" # regexp "^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$"
  display_name = "VaultServiceAccount"
}

resource "google_project_iam_custom_role" "auth-role" {
  role_id     = "vault_auth_role" # regexp "^[a-zA-Z0-9_\\.]{3,64}$"
  title       = "VaultAuthRole"
  description = "Custom role for Vault auth"
  permissions = [
    "iam.serviceAccounts.get",
    "iam.serviceAccountKeys.get",
    "compute.instances.get",
    "compute.instanceGroups.list",
    "iam.serviceAccounts.signJwt"
  ]
}

resource "google_service_account_iam_binding" "admin-account-iam" {
  service_account_id = google_service_account.vault.name
  role               = google_project_iam_custom_role.auth-role.id

  members = [
    "serviceAccount:${google_service_account.vault.email}"
  ]
}

resource "google_project_iam_member" "iam_admin_role" {
  role    = "roles/iam.serviceAccountKeyAdmin"
  project = var.gcp.project
  member  = "serviceAccount:${google_service_account.vault.email}"
}

resource "google_service_account_key" "vault-key" {
  service_account_id = google_service_account.vault.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "local_file" "key" {
  filename = pathexpand("~/.projects/vault/vault-service-account@${var.gcp.project}.json")
  content  = base64decode(google_service_account_key.vault-key.private_key)
}

