output "env_long_name" {
  description = "The three letter description of the environment tier."
  value       = local.env
}

output "env_short_name" {
  description = "The one letter description of the environment tier."
  value       = local.short_env
}

output "product_class" {
  description = "The three letter description of the product class."
  value       = local.product_class
}

output "description" {
  description = "The Description of the subscription"
  value       = local.description
}

output "tenant_id" {
  description = "The Azure Active Directory tenant id assoicated with the subscription."
  value       = data.azurerm_subscription.sub.tenant_id
}

output "subscription_name" {
  description = "The name of the subscription"
  value       = data.azurerm_subscription.sub.display_name
}