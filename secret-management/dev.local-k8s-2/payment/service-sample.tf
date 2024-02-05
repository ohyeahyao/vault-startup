module "service-sample" {
  source = "./../../0-terraform-modules/vault-secret-with-sops"

  secret = {
    mount     = "local-k8s-2"
    file-path = "${path.module}/.secrets/service-sample.json"
    name      = "payment/service-sample"
  }
}
