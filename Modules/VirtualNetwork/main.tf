provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  address_space       = var.virtual_network_address_space
}