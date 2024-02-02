# Enable K/V v2 secrets engine at 'app'
data "sops_file" "secret" {
  source_file = var.secret.file-path
}

resource "vault_kv_secret_v2" "app-secret" {
  mount               = var.secret.mount
  name                = var.secret.name
  cas                 = 1
  delete_all_versions = true
  data_json           = jsonencode(data.sops_file.secret.data)
  custom_metadata {
    max_versions = 5
    data = {
      app = var.secret.name,
    }
  }
}

terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "~> 1.0.0"
    }
  }
}
