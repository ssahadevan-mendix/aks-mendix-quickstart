# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "revision" {
  default = 3
}

resource "random_pet" "prefix" {}

provider "azurerm" {
  features {}
  subscription_id = var.subscriptionId
}

resource "azurerm_resource_group" "default" {
  name     = "${random_pet.prefix.id}-rg"
  #location = "West US 2"
  location = "Central US"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_A2_v2"
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

resource "null_resource" "configure" {

  triggers = {
    on_version_change = "${var.revision}"
  }

  provisioner "local-exec" {
    command = ". ./do-all.sh 2>&1 | tee tout.txt"
  }
  depends_on = [azurerm_kubernetes_cluster.default]
}

