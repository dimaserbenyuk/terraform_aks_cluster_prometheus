resource "kubernetes_deployment" "deployment" {
  depends_on = [kubernetes_config_map.configmap, kubernetes_persistent_volume_claim.pvc]

  metadata {
    name      = "grafana"
    namespace = var.monitoring_name_space
    labels = {
      app = "grafana"
    }
    annotations = {
      "configmap.reloader.stakater.com/reload" = "grafana-datasources"
    }
  }
}
