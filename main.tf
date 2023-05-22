# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "random_pet" "prefix" {}

provider "azurerm" {
  features {}
  subscription_id = var.subscriptionId
}

resource "azurerm_resource_group" "default" {
  name     = "${random_pet.prefix.id}-rg"
  location = "${var.location}"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  #name                = "${random_pet.prefix.id}-aks"
  name                = "${var.clusterName}-${random_pet.prefix.id}"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = "${var.nodeCount}"
    vm_size         = "${var.nodeMachineType}"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }
}


provider "kubernetes" {
  host                   = "${azurerm_kubernetes_cluster.default.kube_config.0.host}"
  client_certificate     = "${base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)}"
}


provider "helm" {
  kubernetes {
  host                   = "${azurerm_kubernetes_cluster.default.kube_config.0.host}"
  client_certificate     = "${base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)}"
  }
}

resource "helm_release" "ingress-ngnix" {
  name  = "ingress-nginx"
  chart = "nginx-stable/nginx-ingress"

  depends_on = [azurerm_kubernetes_cluster.default]
}

resource "null_resource" "configure" {

  triggers = {
    on_version_change = "${var.revision}"
  }

  provisioner "local-exec" {
    command = ". ./do-all.sh 2>&1 | tee tout.txt"
  }
  depends_on = [azurerm_kubernetes_cluster.default, helm_release.ingress-ngnix]
}

