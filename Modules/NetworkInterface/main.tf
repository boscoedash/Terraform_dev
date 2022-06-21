terraform {
  required_version = ">= 0.12"
}

locals {
  ip_configuration_map = var.ip_configuration_map == null ? {} : var.ip_configuration_map
}
resource "azurerm_network_interface" "nic" {
  name                 = var.nic_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  ip_configuration {
    name                          = lookup(local.ip_configuration_map, "name")
    subnet_id                     = lookup(local.ip_configuration_map, "subnet_id")
    private_ip_address_allocation = lookup(local.ip_configuration_map, "private_ip_address_allocation")
  }
}
