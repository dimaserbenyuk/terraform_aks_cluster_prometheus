variable "alertmanager_ingress_host" {
  type    = string
  default = "alertmanager.prometheusit.fun"
}

variable "monitoring_name_space" {
  description = "defualt namespaace for monitoring management tooles"
  type        = string
  default     = "monitoring"
}

variable "alertmanager_service_type" {
  description = "type of kubernetes service for alertmanager"
  type        = string
  default     = "ClusterIP"
}

variable "alertmanager_replica" {
  description = "number of alertmanager replicas"
  type        = number
  default     = 1
}


