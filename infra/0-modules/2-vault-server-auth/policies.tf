# Create admin policy in the root namespace
resource "vault_policy" "policy-admin" {
  name   = "admins"
  policy = file("${path.module}/policies/policy-admin.hcl")
}

resource "vault_policy" "policy-basic" {
  name   = "policy-basic"
  policy = file("${path.module}/policies/policy-basic.hcl")
}

resource "vault_policy" "policy-developer" {
  name   = "policy-developer"
  policy = var.policy-developer
}
