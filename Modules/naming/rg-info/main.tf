data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "region" {
  source   = "../location-name"
  location = data.azurerm_resource_group.rg.location
}

module "sub" {
  source = "../sub-info"
}