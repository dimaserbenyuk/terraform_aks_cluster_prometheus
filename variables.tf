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
variable "prometheus_service_type" {
  description = "type of kubernetes service for prometheus"
  type        = string
  default     = "ClusterIP"
}

variable "grafana_service_type" {
  description = "type of kubernetes service for grafana"
  type        = string
  default     = "ClusterIP"
}

variable "grafana_replica" {
  description = "number of grafana replicas"
  type        = number
  default     = "1"
}

variable "kubestate_replica" {
  description = "number of kube-state-metrics replicas"

  type    = number
  default = 1
}

variable "kubestate_name_space" {
  description = "defualt namespaace for metrics collector"

  type    = string
  default = "kube-system"
}
variable "dev_shared_subscription_id" {
  type        = string
  description = "subscription_id"
}

variable "name" {
  type    = string
  default = "letsencrypt-prod"
}

variable "metrics" {
  description = "Enable prometheus metrics"
  default     = false
  type        = bool
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
###

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
