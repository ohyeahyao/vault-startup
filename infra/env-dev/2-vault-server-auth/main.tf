# cd infra/env-dev/2-vault-server-auth
# terraform init
# terraform plan

data "google_project" "current" {}

module "vault-auth" {
  source = "../../0-modules/2-vault-server-auth"
  gcp = {
    project          = data.google_project.current.project_id
    service_account  = "vault-service-account@{MY_PROJECT_ID}.iam.gserviceaccount.com"
    private_key_path = pathexpand("~/.projects/vault/vault-service-account@{MY_PROJECT_ID}.json")
  }

  policy-developer = file("./policy-developer.hcl")
}
