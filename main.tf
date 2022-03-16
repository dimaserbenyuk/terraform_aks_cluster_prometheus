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
    vm_size             = "Standard_D2_v5"
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
  prometheus_node_port    = var.prometheus_node_port
  prometheus_service_type = var.prometheus_service_type
  # storage_class_name                         = var.storage_class_name
  #prometheus_persistent_volume_claim_storage = var.prometheus_persistent_volume_claim_storage
}

#grafana
#https://github.com/grafana/grafana

module "grafana" {
  source = "./modules/grafana"
  # grafana_ingress_host = var.grafana_ingress_host
  monitoring_name_space                   = var.monitoring_name_space
  grafana_service_type                    = var.grafana_service_type
  grafana_replica                         = var.grafana_replica
  grafana_node_port                       = var.grafana_node_port
  grafana_persistent_volume_claim_storage = var.grafana_persistent_volume_claim_storage
  storage_class_name                      = var.storage_class_name
}
