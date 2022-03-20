# variable "grafana_ingress_host" {
#   type        = string
#   default     = "grafana.winkels.ir"
# }


variable "grafana_service_type" {
  description = "type of kubernetes service for grafana"
  type        = string
  default     = "NodePort"
}

variable "grafana_replica" {
  description = "number of grafana replicas"
  type        = number
  default     = "1"
}
variable "monitoring_name_space" {
  description = "defualt namespaace for monitoring management tooles"
  type        = string
  default     = "monitoring"
}

variable "grafana_node_port" {
  description = "port to expose grafana service"
  type        = number
  default     = "32000"
}
variable "grafana_ingress_host" {
  type    = string
  default = "grafana1648factory.net"
}
variable "letsencrypt_email" {
  type        = string
  description = "Email address that Let's Encrypt will use to send notifications about expiring certificates and account-related issues to."
  default     = "dserbenyukgood@gmail.com"
}

variable "letsencrypt_cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with Zone-DNS-Edit and Zone-Zone-Read permissions, which is required for DNS01 challenge validation."
  default     = "490586b70c70220046232e9881910b7efb57d"
}
