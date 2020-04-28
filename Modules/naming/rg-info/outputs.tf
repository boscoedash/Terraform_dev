output "env_long_name" {
  description = "The three letter description of the environment tier."
  value       = module.sub.env_long_name
}

output "env_short_name" {
  description = "The one letter description of the environment tier."
  value       = module.sub.env_short_name
}

output "product_class" {
  description = "The three letter description of the product class."
  value       = module.sub.product_class
}

output "description" {
  description = "The description of the subscription."
  value       = module.sub.description
}

output "tenant_id" {
  value = module.sub.tenant_id
}

output "subscription_name" {
  value = module.sub.subscription_name
}


output "resource_group_name" {
  value = data.azurerm_resource_group.rg.name
}

output "tags" {
  value = data.azurerm_resource_group.rg.tags
}

output "location" {
  value = data.azurerm_resource_group.rg.location
}

output "location_long_abbv" {
  value = module.region.long_abbv
}

output "location_short_abbv" {
  value = module.region.short_abbv
}

output "rg_object_id" {
  value = data.azurerm_resource_group.rg.id
}