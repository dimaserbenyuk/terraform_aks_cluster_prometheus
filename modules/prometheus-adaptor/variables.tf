variable "helm_stable" {
  source  = "hashicorp/helm"
  version = "2.3.0"
}

variable "monitoring_name_space" {
  description = "defualt namespaace for monitoring management tooles"
  type        = string
  default     = "monitoring"
}
