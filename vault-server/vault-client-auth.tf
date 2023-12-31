

resource "kubernetes_service_account" "vault-auth" {
  metadata {
    namespace = kubernetes_namespace.app-namespace.metadata[0].name
    name      = "vault-auth-service-account"
    annotations = {
      "created-by" = "terraform"
    }
  }
}

resource "kubernetes_secret" "vault-auth-secret" {
  metadata {
    name      = "${kubernetes_service_account.vault-auth.metadata[0].name}-secret"
    namespace = kubernetes_namespace.app-namespace.metadata[0].name
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.vault-auth.metadata[0].name
      "created-by"                         = "terraform"
    }
  }

  type = "kubernetes.io/service-account-token"
}

output "service_account_name" {
  value = kubernetes_service_account.vault-auth.metadata[0].name
}

resource "kubernetes_cluster_role_binding" "role-tokenreview-binding" {
  metadata {
    name = "role-tokenreview-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.vault-auth.metadata[0].name
    namespace = kubernetes_namespace.app-namespace.metadata[0].name
  }
}
