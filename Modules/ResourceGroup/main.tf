terraform {
  required_version = ">= 0.12"
}

resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.resource_group_tags
}
