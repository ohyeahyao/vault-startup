variable "client_k8s_path" {
  type = string
}

variable "client_auths" {
  sensitive = false
  type = list(
    object({
      host               = string
      ca_cert            = string
      token_reviewer_jwt = string
    })
  )
  default = null
}

variable "service_account_namespaces" {
  type    = list(string)
  default = []
}
