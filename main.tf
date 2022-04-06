resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks-rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"
  }
}
#prometheus
resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.monitoring_name_space
  }
}

module "prometheus" {
  #https://github.com/prometheus/prometheus
  source                  = "./modules/prometheus"
  prometheus_replica      = var.prometheus_replica
  monitoring_name_space   = var.monitoring_name_space
  prometheus_service_type = var.prometheus_service_type
}

#grafana
#https://github.com/grafana/grafana

module "grafana" {
  source                = "./modules/grafana"
  monitoring_name_space = var.monitoring_name_space
  grafana_service_type  = var.grafana_service_type
  grafana_replica       = var.grafana_replica
}

module "kube-state-metrics" {
  #https://github.com/kubernetes/kube-state-metrics
  source               = "./modules/kube-state-metrics"
  kubestate_replica    = var.kubestate_replica
  kubestate_name_space = var.kubestate_name_space
}
module "prometheus-node-exporter" {
  source                = "./modules/prometheus-node-exporter"
  monitoring_name_space = var.monitoring_name_space
}

module "cert_manager" {
  source  = "./modules/controller"
  metrics = true
}

module "letsencrypt_issuer" {
  source        = "./modules/letsencrypt"
  namespace     = var.namespace
  name          = var.name
  server        = var.server
  email         = var.email
  ingress_class = var.ingress_class
}

module "alertmanager" {
  #https://github.com/prometheus/alertmanager
  source                    = "./modules/alertmanager"
  monitoring_name_space     = var.monitoring_name_space
  alertmanager_service_type = var.alertmanager_service_type
  alertmanager_replica      = var.alertmanager_replica
}

module "reloader" {
  # https://github.com/stakater/Reloader
  source                = "./modules/reloader"
  monitoring_name_space = var.monitoring_name_space
}

resource "azurerm_application_insights" "appinsights" {
  name                = "grafana-webapp"
  location            = "East US"
  resource_group_name = "prometheus"
  application_type    = "web"
}

resource "azurerm_storage_account" "aks-rg" {
  name                     = "prometheus78543455"
  resource_group_name      = azurerm_resource_group.aks-rg.name
  location                 = azurerm_resource_group.aks-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "aks-rg" {
  name                 = "prometheus-config"
  storage_account_name = azurerm_storage_account.aks-rg.name
  quota                = 50
}

resource "azurerm_storage_container" "aks-rg" {
  name                  = "loki-storage"
  storage_account_name  = azurerm_storage_account.aks-rg.name
  container_access_type = "private"
}

module "loki" {
  source                = "./modules/loki"
  monitoring_name_space = var.monitoring_name_space
}
