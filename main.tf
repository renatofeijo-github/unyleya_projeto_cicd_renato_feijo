provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = "rg_unyleya"
  location = "East US"
}

# Criação do ACR
resource "azurerm_container_registry" "acr" {
  name                     = "unyleyaregistry"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Basic"
  admin_enabled            = true
}

# Criação do AKS
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-unyleya-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksproject"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }

  depends_on = [
    azurerm_container_registry.acr
  ]
}

# Conexão entre AKS e ACR
resource "azurerm_role_assignment" "aks_acr_role" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}