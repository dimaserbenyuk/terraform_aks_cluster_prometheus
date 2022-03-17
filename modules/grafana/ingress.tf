resource "kubernetes_ingress" "ingress" {
  metadata {
    name      = "grafana"
    namespace = "monitoring"

    annotations = {
      "cert-manager.io/cluster-issuer"           = "letsencrypt-staging"
      "traefik.ingress.kubernetes.io/router.tls" = "true"
    }
  }
  spec {
    rule {
      host = var.grafana_ingress_host
      http {
        path {
          path = "/"
          backend {
            service_name = "grafana"
            service_port = 3000
          }
        }
      }
    }
    tls {
      hosts       = ["grafana1648factory.net"]
      secret_name = "prometheus-tls-secret"
    }
  }
}
