output "service-account-email" {
  value = google_service_account.vault.email
}
output "service-account-key-id" {
  value = google_service_account_key.vault-key.id
}

output "private-key-path" {
  value = local_file.key.filename
}
