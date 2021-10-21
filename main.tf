terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.78"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = ["10.1.0.0/16"]

  depends_on = [
    azurerm_resource_group.rg,
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/22"]

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_public_ip" "pub-ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"

  depends_on = [
    azurerm_resource_group.rg,
  ]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                      = var.aks_name
  location                  = var.location
  resource_group_name       = var.resource_group

  #why?
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = var.nodepool_vm_sku
    vnet_subnet_id  = azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_subnet.subnet
  ]
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "public_ip" {
  value = azurerm_public_ip.pub-ip.ip_address
}
