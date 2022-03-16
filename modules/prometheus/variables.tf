variable "prometheus_replica" {
  description = "number of prometheus replicas"
  default     = "1"
}
variable "monitoring_name_space" {
  description = "defualt namespaace for monitoring management tooles"
  type        = string
  default     = "monitoring"
}
variable "prometheus_node_port" {
  type        = number
  description = "port to expose prometheus service"
}
variable "prometheus_service_type" {
  type        = string
  description = "type of kubernetes service for prometheus"
}
#variable "storage_class_name" {
# default     = "nfs"
# type        = string
# description = "storageClass for dynamically provisioning"
#}
#variable "prometheus_persistent_volume_claim_storage" {
#  type        = string
#  description = "proemtheus storage size"
#}
