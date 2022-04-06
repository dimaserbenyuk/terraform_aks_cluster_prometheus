
provider "azurerm" {
  features {}
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
  }
}
resource "kubernetes_secret" "mysecret" {
  metadata {
    name      = "azure-secret"
    namespace = var.monitoring_name_space
  }

  data = {
    azurestorageaccountname = "prometheus87564312"
    azurestorageaccountkey  = "zK+M/0Do1s4nel9Ng5EsPKiwLpFkmDkCvBBagC7VurolqcdpZhTjqA7ngWJT7V0qV73c1ou8j1Hb+AStaF7GMQ=="
  }

  type = "Opaque"
}
/*
resource "kubernetes_persistent_volume_claim" "sample_storage_claim" {
  metadata {
    name      = "sample-storage-claim"
    namespace = var.monitoring_name_space
  }
  spec {
    access_modes = ["ReadWriteMany"]

    resources {
      requests = {
        storage = "10Gi"
      }
    }
    storage_class_name = "prometheus-pvc"
  }
}

resource "kubernetes_persistent_volume" "data" {
  metadata {
    name = "sample-storage"
  }
  spec {
    capacity = {
      storage = "10Gi"
    }
    access_modes       = ["ReadWriteMany"]
    storage_class_name = "prometheus-pvc"

    persistent_volume_source {
      azure_file {
        secret_namespace = "monitoring" # Here is the argument yet to be supported in TF provider
        secret_name      = "azure-secret"
        share_name       = "blabla"
        read_only        = "false"
      }
    }
  }
}

resource "kubernetes_storage_class" "prometheus-pvc" {
  metadata {
    name = "prometheus-pvc"
  }
  storage_provisioner = "kubernetes.io/azure-file"
  reclaim_policy      = "Delete"
  parameters = {
    skuName = "Standard_LRS"
  }
  mount_options          = ["file_mode=0777", "dir_mode=0777", "uid=1000", "gid=1000"]
  allow_volume_expansion = true
}
*/
