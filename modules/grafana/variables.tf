# variable "grafana_ingress_host" {
#   type        = string
#   default     = "grafana.winkels.ir"
# }


variable "grafana_service_type" {
  description = "type of kubernetes service for grafana"
  type        = string
  default     = "ClusterIP"
  #default     = "LoadBalancer"
  #default = "NodePort"
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

#variable "grafana_node_port" {
#  description = "port to expose grafana service"
#  type        = number
#  default     = "32000"
#}
variable "grafana_ingress_host" {
  type    = string
  default = "prometheusit.fun"
}
variable "alertmanager_ingress_host" {
  type    = string
  default = "alertmanager.prometheusit.fun"
}
variable "prometheus_ingress_host" {
  type    = string
  default = "prometheus.prometheusit.fun"
}
