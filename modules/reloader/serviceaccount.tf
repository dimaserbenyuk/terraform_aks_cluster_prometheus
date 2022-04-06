resource "kubernetes_service_account" "service-account" {
  metadata {
    name      = "config-reloader"
    namespace = var.monitoring_name_space
    labels = {
      "app"      = "config-reloader"
      "chart"    = "reloader-v0.0.110"
      "release"  = "reloader"
      "heritage" = "Tiller"
    }
  }
}
