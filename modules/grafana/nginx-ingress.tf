resource "kubernetes_namespace" "nginx_ingress" {
  metadata {
    name = "ingress-nginx"
  }
}

locals {
  metrics = {
    "prometheus.enabled"                    = "true"
    "podAnnotations.prometheus\\.io/scrape" = "true"
    "podAnnotations.prometheus\\.io/path"   = "/metrics"
    "podAnnotations.prometheus\\.io/port"   = "10254"
    "podAnnotations.prometheus\\.io/port"   = "9901"
  }
}

module "nginx_ingress" {
  source     = "terraform-module/release/helm"
  version    = "2.6.10"
  namespace  = kubernetes_namespace.nginx_ingress.metadata.0.name
  repository = "https://kubernetes.github.io/ingress-nginx"
  app = {
    name          = "ingress-nginx"
    version       = "4.0.18"
    chart         = "ingress-nginx"
    force_update  = true
    wait          = false
    recreate_pods = false
    deploy        = 1
  }

  set = [
    {
      name  = "replicaCount"
      value = 2
    }
  ]
}
