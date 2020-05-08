
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

locals {
  tags     = (var.tags == null ? data.azurerm_resource_group.rg.tags : var.tags)
  location = data.azurerm_resource_group.rg.location
}