module "naming" {
  source      = "../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "nsg"
}

resource "azurerm_network_security_group" "nsg" {
  name                = module.naming.name
  location            = local.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  security_rule = var.securityrules
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_watcher_flow_log" "nsg_flow_log" {
  network_watcher_name      = var.network_watcher_name
  resource_group_name       = var.network_watcher_resource_group_name
  network_security_group_id = azurerm_network_security_group.nsg.id
  storage_account_id        = var.storage_account_id

  enabled = var.nsg_flow_log_enabled
  version = var.nsg_flow_log_version

  retention_policy {
    enabled = var.nsg_flow_log_retention_enabled
    days    = var.retention_policy_days
  }

  traffic_analytics {
    enabled               = var.nsg_flow_log_traffic_analysis_enabled
    workspace_id          = var.workspace_id
    workspace_region      = var.workspace_region
    workspace_resource_id = var.log_analytics_workspace_id
    interval_in_minutes   = var.interval_in_minutes
  }
}

resource "azurerm_monitor_diagnostic_setting" "log-analytics" {
  name                       = "log-analytics"
  target_resource_id         = azurerm_network_security_group.nsg.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "NetworkSecurityGroupEvent"
    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  log {
    category = "NetworkSecurityGroupRuleCounter"
    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }
}