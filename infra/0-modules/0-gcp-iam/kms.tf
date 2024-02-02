resource "google_kms_key_ring" "key_ring" {
  project  = var.gcp.project
  name     = "vault-keyring"
  location = "global"
}

# Create a crypto key for the key ring
resource "google_kms_crypto_key" "crypto_key" {
  name            = "vault-key"
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = "31536000s" # 365days
}

resource "google_kms_key_ring_iam_binding" "vault_iam_kms_binding" {
  key_ring_id = google_kms_key_ring.key_ring.id
  role        = "roles/owner"

  members = [
    "serviceAccount:${google_service_account.vault.email}",
  ]
}
