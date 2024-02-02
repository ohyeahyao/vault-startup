resource "vault_gcp_auth_backend" "gcp" {
  credentials = file(var.gcp.private_key_path)
  path        = "gcp"
}

resource "vault_gcp_auth_backend_role" "iac-role" {
  backend                = vault_gcp_auth_backend.gcp.path
  role                   = "gcp-iac-role"
  type                   = "iam"
  bound_service_accounts = [var.gcp.service_account]
  bound_projects         = [var.gcp.project]
  max_jwt_exp            = "3600" #TODO: check JWT token expire time
  token_policies         = ["admins", "policy-basic", "policy-developer"]
  token_explicit_max_ttl = 60
  add_group_aliases      = true
}

output "gcp_auth_role" {
  value = vault_gcp_auth_backend_role.iac-role.role
}
