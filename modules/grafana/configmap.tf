resource "kubernetes_config_map" "configmap" {
  metadata {
    name          = "grafana-datasources"
    namenamespace = var.monitoring_name_space
    labels = {
      name = "grafana-datasources"
    }
  }
  data = {
    "datasources.yaml" = "${file("${path.module}/datasources.yml")}"
  }
}
