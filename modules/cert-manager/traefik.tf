
resource "helm_release" "traefik" {
  name       = "traefik"
  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"
  version    = "9.18.2"
  namespace  = var.monitoring_name_space

  #set {
  #  name  = "ports.web.redirectTo"
  #  value = "websecure"
  #}

  # Trust private AKS IP range
  set {
    name  = "additionalArguments"
    value = "{--entryPoints.websecure.forwardedHeaders.trustedIPs=10.0.0.0/8}"
  }
}

data "kubernetes_service" "traefik" {
  metadata {
    name      = helm_release.traefik.name
    namespace = var.monitoring_name_space
  }
}

resource "cloudflare_record" "traefik" {
  zone_id = "e617733fb42a7dc87c2bf4bd417daf9a"
  name    = "grafana1648factory.net"
  type    = "A"
  value   = data.kubernetes_service.traefik.status.0.load_balancer.0.ingress.0.ip
  proxied = true
}

provider "cloudflare" {
  email   = var.letsencrypt_email
  api_key = "490586b70c70220046232e9881910b7efb57d"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.7.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}
