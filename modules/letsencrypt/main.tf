resource "kubernetes_secret" "letsencrypt_issuer_secret" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
}


resource "kubernetes_manifest" "letsencrypt_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = var.name
      labels = {
        name = var.name
      }
    }
    spec = {
      acme = {
        server = var.server
        email  = var.email
        privateKeySecretRef = {
          name = "letsencrypt-prod-private-key"
        }
        solvers = [
          {
            http01 = {
              ingress = {
                class = var.ingress_class
              }
            }
          }
        ]
      }
    }
  }
}

