module "app2" {
  source = "./../../0-terraform-modules/vault-secret-with-sops"

  secret = {
    mount     = "local-k8s-1"
    file-path = "${path.module}/.secrets/app2.json"
    name      = "data-consumer/app2"
  }
}
