resource "kubernetes_deployment" "deployment" {
  depends_on = [kubernetes_config_map.configmap]

  metadata {
    name      = "grafana-app"
    namespace = var.monitoring_name_space
    labels = {
      app = "grafana-app"
    }
    annotations = {
      "configmap.reloader.stakater.com/reload" = "grafana-datasources"
    }
  }
  spec {
    replicas = var.grafana_replica
    selector {
      match_labels = {
        app = "grafana-app"
      }
    }
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = 1
        max_unavailable = "33%"
      }
    }

    template {
      metadata {
        labels = {
          app = "grafana-app"
        }
      }

      spec {
        volume {
          name = "grafana-storage"
        }

        volume {
          name = "grafana-datasources"

          config_map {
            name         = "grafana-datasources"
            default_mode = "0644"

          }
        }
        volume {
          name = "conf"

          config_map {
            name         = "custom-ini"
            default_mode = "0777"
          }
        }
        volume {
          name = "dashboardproviders"

          config_map {
            name         = "dashboardproviders"
            default_mode = "0777"
          }
        }
        volume {
          name = "dashboards-node-exporter-full"

          config_map {
            name         = "node-exporter-full"
            default_mode = "0777"
          }
        }

        container {
          name  = "grafana"
          image = "grafana/grafana:latest"
          tty   = "true"
          stdin = "true"

          port {
            name           = "grafana-service"
            container_port = 3000
          }
          env {
            name  = "GF_SERVER_ROOT_URL"
            value = "https://prometheusit.fun/"
          }
          env {
            name  = "GRAFANA_PORT"
            value = "3000"
          }

          resources {
            limits = {
              cpu    = "2000m"
              memory = "4Gi"
            }

            requests = {
              cpu    = "1000m"
              memory = "2Gi"
            }
          }

          volume_mount {
            name       = "grafana-storage"
            mount_path = "/var/lib/grafana"
          }

          volume_mount {
            name       = "grafana-datasources"
            mount_path = "/etc/grafana/provisioning/datasources"
          }
          volume_mount {
            name       = "conf"
            mount_path = "/etc/grafana"
          }
          volume_mount {
            name       = "dashboardproviders"
            mount_path = "/etc/grafana/provisioning/dashboards"
          }
          volume_mount {
            name       = "dashboards-node-exporter-full"
            mount_path = "/var/lib/grafana/dashboards/node-exporter-full"
          }
        }
        automount_service_account_token = true
        # node_selector = {
        #   type = "master"
        # }
        security_context {
          fs_group = "472"
        }
      }
    }
  }
}


resource "kubernetes_service" "service" {
  metadata {
    name      = "grafana-service"
    namespace = var.monitoring_name_space
    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/port"   = "3000"
    }
  }
  spec {
    selector = {
      app = "grafana-app"
    }
    port {
      port        = 80
      target_port = 3000
    }
    type = var.grafana_service_type
  }
}

resource "kubernetes_ingress" "ingress" {
  metadata {
    name      = "grafana-app"
    namespace = "monitoring"

    annotations = {
      "kubernetes.io/ingress.class"            = "nginx"
      "cert-manager.io/cluster-issuer"         = "letsencrypt-prod"
      "nginx.ingress.kubernetes.io/router.tls" = "true"
    }
  }
  spec {
    rule {
      host = var.grafana_ingress_host
      http {
        path {
          path = "/"
          backend {
            service_name = "grafana-service"
            service_port = 3000
          }
        }
      }
    }
    tls {
      hosts       = ["prometheusit.fun"]
      secret_name = "grafana-tls-secret"
    }
    rule {
      host = var.alertmanager_ingress_host
      http {
        path {
          path = "/"
          backend {
            service_name = "alertmanager"
            service_port = 9093
          }
        }
      }
    }
    tls {
      hosts       = ["alertmanager.prometheusit.fun"]
      secret_name = "alertmanager-tls-secret"
    }
    rule {
      host = var.prometheus_ingress_host
      http {
        path {
          path = "/"
          backend {
            service_name = "prometheus-service"
            service_port = 9090
          }
        }
      }
    }
    tls {
      hosts       = ["prometheus.prometheusit.fun"]
      secret_name = "prometheus-tls-secret"
    }
  }
}

