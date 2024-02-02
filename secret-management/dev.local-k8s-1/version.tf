terraform {
  required_version = ">= 1"

  required_providers {
    google = ">=5.11"
  }

  backend "gcs" {
    bucket = "dev-tf-state"
    prefix = "vault-secret-management/dev.local-k8s-1"
  }
}

# kubectl config use-context local-k8s-1
# VAULT_SERVER_IP=$(kubectl get svc "vault-ui" -n vault -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
# VAULT_ADDR=http://${VAULT_SERVER_IP}:8200
# echo ${VAULT_ADDR}
provider "vault" {
  address = "{VAULT_ADDR}"
  auth_login_gcp {
    mount           = "gcp"
    role            = "gcp-iac-role"
    service_account = "vault-service-account@{MY_PROJECT_ID}.iam.gserviceaccount.com"
    credentials     = "~/.projects/vault/vault-service-account@{MY_PROJECT_ID}.json"
  }
}
