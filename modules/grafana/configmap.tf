resource "kubernetes_config_map" "configmap" {
  metadata {
    name          = "grafana-datasources"
    namenamespace = var.monitoring_name_space
    labels = {
      name = "grafana-datasources"
    }
  }
  data = {
    "prometheus.yaml" = "${file("${path.module}/prometheus.yml")}"
  }
}
