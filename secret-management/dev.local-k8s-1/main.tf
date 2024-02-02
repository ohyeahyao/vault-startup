# cd vault/secret-management/dev.local-k8s-1
# terraform init
# terraform plan
# terraform apply

module "local-k8s-1" {
  source      = "../0-terraform-modules/vault-mounts"
  vault-mount = "local-k8s-1"
}

# namespace: app
module "app" {
  source = "./app"
}

# namespace: logging
module "logging" {
  source = "./logging"
}
