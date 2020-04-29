module "naming" {
  source      = "../../../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "ain"
}

resource "azurerm_application_insights" "application_insights" {
  name                                  = lower(module.naming.name)
  location                              = local.location
  resource_group_name                   = var.resource_group_name
  application_type                      = var.application_type
  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb 
  daily_data_cap_notifications_disabled = var.daily_data_cap_notifications_disabled
  retention_in_days                     = var.retention_in_days
  sampling_percentage                   = var.sampling_percentage
  disable_ip_masking                    = var.disable_ip_masking
  tags                                  = local.tags
}
