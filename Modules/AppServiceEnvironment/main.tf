module "naming" {
  source      = "../../../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "ase"
}

resource "azurerm_app_service_environment" "app_service_environment" {
  name                   = lower(module.naming.name)
  subnet_id              = var.subnet_id
  pricing_tier           = var.pricing_tier
  front_end_scale_factor = var.front_end_scale_factor
}
