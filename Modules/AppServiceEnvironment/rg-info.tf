
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

locals {
  location = data.azurerm_resource_group.rg.location
}