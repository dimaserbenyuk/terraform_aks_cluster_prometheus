variable "prometheus_replica" {
  description = "number of prometheus replicas"
  default     = "1"
}
variable "monitoring_name_space" {
  description = "defualt namespaace for monitoring management tooles"
  type        = string
  default     = "monitoring"
}
variable "prometheus_service_type" {
  type        = string
  default     = "NodePort"
  description = "type of kubernetes service for prometheus"
}
variable "prometheus_node_port" {
  description = "port to expose prometheus service"
  default     = "30000"
}

