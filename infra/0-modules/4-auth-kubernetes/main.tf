resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
  path = var.client_k8s_path
}

resource "vault_kubernetes_auth_backend_role" "cluster-role" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "vso-auth-role"
  bound_service_account_names      = ["vault-auth-service-account"]
  bound_service_account_namespaces = var.service_account_namespaces
  token_ttl                        = 3600
  token_policies                   = ["admins", "base-policy", "policy-developer"]
  audience                         = "vault"
}

resource "vault_kubernetes_auth_backend_config" "cluster-config" {
  for_each = { for idx, auth in var.client_auths : idx => auth }

  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = each.value.host
  disable_iss_validation = true
  disable_local_ca_jwt   = true
  kubernetes_ca_cert     = each.value.ca_cert
  token_reviewer_jwt     = each.value.token_reviewer_jwt
}
