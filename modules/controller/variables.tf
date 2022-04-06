
variable "metrics" {
  description = "Enable prometheus metrics"
  default     = false
  type        = bool
}
variable "monitoring_name_space" {
  description = "defualt namespaace for monitoring management tooles"
  type        = string
  default     = "cert-manager"
}
