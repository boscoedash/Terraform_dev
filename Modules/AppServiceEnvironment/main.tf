resource "azurerm_app_service_environment" "app_service_environment" {
  name                         = var.app_service_environment_name
  resource_group_name          = var.resource_group_name
  subnet_id                    = var.subnet_id
  pricing_tier                 = var.ase_pricing_tier
  front_end_scale_factor       = var.front_end_scale_factor
  internal_load_balancing_mode = var.internal_load_balancing_mode
  allowed_user_ip_cidrs        = var.allowed_user_ip_cidrs
}
