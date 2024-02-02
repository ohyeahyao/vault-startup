# cd infra/env-dev/0-preparing
# terraform init
# terraform plan 
data "google_project" "current" {}

module "gcp-iam" {
  source = "./../../0-modules/0-gcp-iam"

  gcp = {
    project = data.google_project.current.project_id
  }
}

output "service-account-key-id" {
  value = module.gcp-iam.service-account-key-id
}

output "service-account-email" {
  value = module.gcp-iam.service-account-email
}

output "private-key-path" {
  value = module.gcp-iam.private-key-path
}
