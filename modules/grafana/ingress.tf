resource "kubernetes_ingress" "ingress" {
  metadata {
    name      = "grafana"
    namespace = "monitoring"

    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/*"

          backend {
            service_name = kubernetes_service.service.metadata.0.name
            service_port = "8080"
          }
        }
      }
    }
  }
}
