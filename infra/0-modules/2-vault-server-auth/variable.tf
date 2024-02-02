variable "gcp" {
  type = object({
    service_account  = string
    project          = string
    private_key_path = string
  })
}

variable "policy-developer" {
  type = string
}
