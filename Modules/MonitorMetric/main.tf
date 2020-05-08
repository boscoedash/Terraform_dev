module "naming" {
  source      = "../../../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "mma"
}

locals {
    action_map    = var.action_map == null ? {} : var.action_map
    criteria_map  = var.criteria_map == null ? {} : var.criteria_map
    dimension_map = var.dimension_map == null ? {} : var.dimension_map
}

resource "azurerm_monitor_metric_alert" "monitor_metric_alert" {
    name                = lower(module.naming.name)
    resource_group_name = var.resource_group_name
    scopes              = var.scopes
    enabled             = var.enabled
    auto_mitigate       = var.auto_mitigate
    description         = var.alert_description
    frequency           = var.frequency
    severity            = var.severity
    window_size         = var.window_size
    tags                = local.tags

    dynamic "action" {
        for_each = local.action_map

        content {
            action_group_id    = lookup(action.value, "action_group_id")
            webhook_properties = lookup(action.value, "webhook_properties")
        }
    }

    dynamic "criteria" {
        for_each = local.criteria_map

        content {
            metric_namespace = lookup(criteria.value, "metric_namespace")
            metric_name = lookup(criteria.value, "metric_name")
            aggregation = lookup(criteria.value, "aggregation")
            operator = lookup(criteria.value, "operator")
            threshold = lookup(criteria.value, "threshold")

            dynamic "dimension" {
                for_each = local.dimension_map

                content {
                    name     = lookup(dimension.value, "name")
                    operator = lookup(dimension.value, "operator")
                    values   = lookup(dimension.value, "values")
                }
            }
        }
    }
}