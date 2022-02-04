variable "shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "availability_domain" {
  type    = number
  default = 0
}

variable "name" {
  type    = string
  default = "terraform-deploy"
}

variable "path_local_public_key" {
  default = "~/.ssh/id_rsa.pub"
  sensitive = true
}