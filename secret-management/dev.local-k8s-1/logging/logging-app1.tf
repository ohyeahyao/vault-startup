module "logging-app1" {
  source = "./../../0-terraform-modules/vault-secret-with-sops"

  secret = {
    mount     = var.cluster-path
    file-path = "${path.module}/.secrets/logging-app1.json"
    name      = "logging/logging-app1"
  }
}
