module "naming" {
  source      = "../../../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "asp"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                         = lower(module.naming.name)
  location                     = local.location
  resource_group_name          = var.resource_group_name
  kind                         = var.kind
  maximum_elastic_worker_count = var.maximum_elastic_worker_count
  app_service_environment_id   = var.app_service_environment_id
  reserved                     = var.reserved
  per_site_scaling             = var.per_site_scaling
  tags                         = local.tags

  sku {
    tier     = lookup(var.sku_map, "tier", "Isolated")
    size     = lookup(var.sku_map, "size")
    capacity = lookup(var.sku_map, "capacity", 2)
  }
}
