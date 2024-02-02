resource "vault_mount" "vault-mount" {
  path = var.vault-mount
  type = "kv-v2"
}

output "vault-mount" {
  value = vault_mount.vault-mount.path
}
