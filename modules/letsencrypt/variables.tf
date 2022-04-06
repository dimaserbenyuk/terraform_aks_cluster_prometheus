
variable "name" {
  type    = string
  default = "letsencrypt-prod"
}
variable "namespace" {
  description = "defualt namespaace for monitoring management tooles"
  type        = string
  default     = "cert-manager"
}
variable "server" {
  type    = string
  default = "https://acme-v02.api.letsencrypt.org/directory"
}
variable "email" {
  type    = string
  default = "dserbenyukgood@gmail.com"
}
variable "ingress_class" {
  type    = string
  default = "nginx"
}
