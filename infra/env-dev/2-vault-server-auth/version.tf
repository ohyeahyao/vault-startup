terraform {
  required_version = ">= 1"

  required_providers {
    google = ">=5.11"
  }

  # backend "gcs" {
  #   bucket = "dev-tf-state"
  #   prefix = "vault-infra/2-vault-server-auth"
  # }
}

provider "google" {
  project = "{MY_PROJECT_ID}"
  region  = "asia-east1"
}

# kubectl config use-context local-k8s-1
# VAULT_SERVER_IP=$(kubectl get svc "vault-ui" -n vault -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
# VAULT_ADDR=http://${VAULT_SERVER_IP}:8200
# echo ${VAULT_ADDR}
provider "vault" {
  address = "VAULT_ADDR"
  token   = var.vault_token
}
