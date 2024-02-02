variable "secret" {
  type = object({
    file-path = string
    name      = string
    mount     = string
  })
}
