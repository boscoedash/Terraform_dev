provider "azurerm" {
  features {}
}

module "naming" {
  source      = "../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "ehns"
}

locals {
  virtual_network_rule_map = var.virtual_network_rule_map == null ? {} : var.virtual_network_rule_map
  ip_rule_map              = var.ip_rule_map == null ? {} : var.ip_rule_map
}

resource "azurerm_eventhub_namespace" "event_hub_namespace" {
  name                     = lower(module.naming.name)
  location                 = local.location
  resource_group_name      = var.resource_group_name
  sku                      = var.sku == null ? "Standard" : var.sku
  capacity                 = var.capacity == null ? 2 : var.capacity
  tags                     = local.tags
  auto_inflate_enabled     = var.auto_inflate_enabled
  maximum_throughput_units = var.maximum_throughput_units
  
  dynamic "network_rulesets" {
      foreach = var.network_rulesets_map
        content {
            default_action = lookup(var.network_rulesets.value, "default_action")

            dynamic "virtual_network_rule" {
                foreach = local.virtual_network_rule_map 
                content {
                    subnet_id                                       = lookup(virtual_network_rule.value, "subnet_id")
                    ignore_missing_virtual_network_service_endpoint = lookup(virtual_network_rule.value, "ignore_missing_virtual_network_service_endpoint", false)
                }
            }

            dynamic "ip_rule" {
                foreach = local.ip_rule_map 
                content {
                    ip_mask = lookup(ip_rule.value, "ip_mask")
                    action  = lookup(ip_rule_map.value, "action", "Allow")
                }
            }
        }
    }
}