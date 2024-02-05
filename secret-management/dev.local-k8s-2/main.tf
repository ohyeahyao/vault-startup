# cd vault/secret-management/dev.local-k8s-2
# terraform init
# terraform plan
# terraform apply

module "local-k8s-2" {
  source      = "../0-terraform-modules/vault-mounts"
  vault-mount = "local-k8s-2"
}

# namespace: payment
module "payment" {
  source = "./payment"
}
