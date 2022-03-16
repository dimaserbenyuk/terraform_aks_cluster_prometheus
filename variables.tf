variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}
variable "acr_name" {
  type        = string
  description = "ACR name"
}

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
  description = "port to expose prometheus service"
  default     = "30000"
}
variable "prometheus_service_type" {
  description = "type of kubernetes service for prometheus"
  type        = string
  default     = "NodePort"
}
#variable "storage_class_name" {
# description = "storageClass for dynamically provisioning"
# type        = string
# default     = "standard"
#}
#variable "prometheus_persistent_volume_claim_storage" {
# description = "proemtheus storage size"
# type        = string
# default     = "3Gi"
#}
#grafana
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

variable "grafana_node_port" {
  description = "port to expose grafana service"
  type        = number
  default     = "32000"
}

variable "grafana_persistent_volume_claim_storage" {
  description = "grafana storage size"
  type        = string
  default     = "5Gi"
}

variable "storage_class_name" {
  description = "storageClass for dynamically provisioning"
  type        = string
  default     = "Standard_LRS"
}
