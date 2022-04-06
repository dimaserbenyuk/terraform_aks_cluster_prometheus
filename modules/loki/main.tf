resource "helm_release" "loki" {
  #https://github.com/prometheus/node_exporter. http://loki.monitoring.svc:3100
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  version    = "2.10.3"
  chart      = "loki"
  namespace  = var.monitoring_name_space
  values = [
    "${file("${path.module}/loki-values.yaml")}"
  ]
  atomic          = true
  cleanup_on_fail = true
}

resource "helm_release" "promtail" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  version    = "3.11.0"
  chart      = "promtail"
  namespace  = var.monitoring_name_space
  values = [
    "${file("${path.module}/promtail-values.yaml")}"
  ]
  atomic          = true
  cleanup_on_fail = true
}
