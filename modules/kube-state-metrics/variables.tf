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
