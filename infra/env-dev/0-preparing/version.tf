terraform {
  required_version = ">= 1"

  required_providers {
    google = ">=5.11"
  }
  # backend "gcs" {
  #   bucket = "dev-tf-state"
  #   prefix = "vault-infra/0-preparing"
  # }
}

provider "google" {
  project = "{MY_PROJECT_ID}"
  region  = "asia-east1"
}
