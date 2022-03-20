resource "kubernetes_deployment" "deployment" {
  depends_on = [kubernetes_config_map.configmap]

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
  spec {
    replicas = var.grafana_replica
    selector {
      match_labels = {
        app = "grafana"
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
          app = "grafana"
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

        container {
          name  = "grafana"
          image = "grafana/grafana:latest"

          port {
            name           = "grafana"
            container_port = 3000
          }

          resources {
            limits = {
              cpu = "4"

              memory = "4Gi"
            }

            requests = {
              cpu = "500m"

              memory = "500M"
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
    name      = "grafana"
    namespace = var.monitoring_name_space
    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/port"   = "3000"
    }
  }
  spec {
    selector = {
      app = "grafana"
    }
    port {
      port        = 3000
      target_port = 3000
      node_port   = var.grafana_node_port
    }

    type = var.grafana_service_type
  }
}
