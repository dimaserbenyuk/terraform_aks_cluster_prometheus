resource "kubernetes_config_map" "configmap" {
  metadata {
    name      = "alertmanager-config"
    namespace = var.monitoring_name_space
  }
  data = {
    "config.yml" = "${file("${path.module}/configmain.yml")}"
  }

}

resource "kubernetes_config_map" "configmap_template" {
  metadata {
    name      = "alertmanager-templates"
    namespace = var.monitoring_name_space
  }
  data = {
    "default.tmpl" = "${file("${path.module}/default.tmpl")}"
  }

}
