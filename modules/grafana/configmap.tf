resource "kubernetes_config_map" "configmap" {
  metadata {
    name      = "grafana-datasources"
    namespace = var.monitoring_name_space
    labels = {
      name = "grafana-datasources"
    }
  }
  data = {
    "datasources.yaml" = "${file("${path.module}/datasources.yml")}"
  }
}

resource "kubernetes_config_map" "configmap-init" {
  metadata {
    name      = "custom-ini"
    namespace = var.monitoring_name_space
    labels = {
      name = "custom-ini"
    }
  }
  data = {
    "grafana.ini" = "${file("${path.module}/grafana.ini")}"
  }
}

resource "kubernetes_config_map" "configmap-dashboardproviders" {
  metadata {
    name      = "dashboardproviders"
    namespace = var.monitoring_name_space
    labels = {
      name = "dashboardproviders"
    }
  }
  data = {
    "dashboardproviders.yml" = "${file("${path.module}/dashboardproviders.yml")}"
  }
}
resource "kubernetes_config_map" "node-exporter-full" {
  metadata {
    name      = "node-exporter-full"
    namespace = var.monitoring_name_space
    labels = {
      name = "node-exporter-full"
    }
  }
  data = {
    "Node-Exporter-Full.json" = "${file("${path.module}/Node-Exporter-Full.json")}"
  }
}
