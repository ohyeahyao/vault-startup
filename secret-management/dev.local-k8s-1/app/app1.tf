module "app1" {
  source = "./../../0-terraform-modules/vault-secret-with-sops"

  secret = {
    mount     = "local-k8s-1"                       # cluster-context-name
    file-path = "${path.module}/.secrets/app1.json" # encrypted file with sops
    name      = "data-consumer/app1"                # namespace:app
  }
}
