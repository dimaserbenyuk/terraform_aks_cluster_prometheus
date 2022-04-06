resource "helm_release" "prometheus-node-exporter" {
  #https://github.com/prometheus/node_exporter
  name       = "prometheus-node-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "3.1.0"
  chart      = "prometheus-node-exporter"
  namespace  = var.monitoring_name_space
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
  atomic          = true
  cleanup_on_fail = true
}
