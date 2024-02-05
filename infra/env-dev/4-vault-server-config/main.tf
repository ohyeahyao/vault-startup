# terraform init
# terraform plan
# terraform apply

data "kubernetes_secret" "local-k8s-1-vault-auth-sa" {
  provider = kubernetes.local-k8s-1
  metadata {
    name      = "vault-auth-service-account"
    namespace = "vault-secrets-operator-system"
  }
}

module "local-k8s-1-auth" {
  source = "./../../0-modules/4-auth-kubernetes"

  client_k8s_path = "local-k8s-1-auth-mount"

  client_auths = [
    {
      host               = "https://kubernetes.default.svc.cluster.local"
      ca_cert            = data.kubernetes_secret.local-k8s-1-vault-auth-sa.data["ca.crt"]
      token_reviewer_jwt = data.kubernetes_secret.local-k8s-1-vault-auth-sa.data["token"]
    }
  ]

  ## serviceAccount.namespaces
  ## ref: infra/env-dev/3-vault-client-vso/local-k8s-1-vso.values.yaml
  service_account_namespaces = [
    "app",
    "logging",
    "vault-secrets-operator-system"
  ]
}


data "kubernetes_secret" "local-k8s-2-vault-auth-sa" {
  provider = kubernetes.local-k8s-2
  metadata {
    name      = "vault-auth-service-account"
    namespace = "vault-secrets-operator-system"
  }
}

module "local-k8s-2-auth" {
  source = "./../../0-modules/4-auth-kubernetes"

  client_k8s_path = "local-k8s-2-auth-mount"

  client_auths = [
    {
      host               = "{LOCAL_K8S_2_HOST_ADDRESS}"
      ca_cert            = data.kubernetes_secret.local-k8s-2-vault-auth-sa.data["ca.crt"]
      token_reviewer_jwt = data.kubernetes_secret.local-k8s-2-vault-auth-sa.data["token"]
    }
  ]

  ## serviceAccount.namespaces
  ## ref: infra/env-dev/3-vault-client-vso/local-k8s-2-vso.values.yaml
  service_account_namespaces = [
    "data-consumer",
    "payment",
    "category",
    "vault-secrets-operator-system"
  ]
}

