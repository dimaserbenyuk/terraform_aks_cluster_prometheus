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

variable "letsencrypt_email" {
  type        = string
  description = "Email address that Let's Encrypt will use to send notifications about expiring certificates and account-related issues to."
  default     = "dserbenyukgood@gmail.com"
}

variable "letsencrypt_cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with Zone-DNS-Edit and Zone-Zone-Read permissions, which is required for DNS01 challenge validation."
  default     = "guZQe9T6s6nZhm7WqNhn9ry0-ogXVkZzVdubBv3a"
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
