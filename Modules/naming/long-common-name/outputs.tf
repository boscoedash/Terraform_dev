output "name" {
  description = "The generated name"
  value = lower(format("%s-%s-%s-%s-%s%02d",
    module.info.subscription_name,
    module.info.location_long_abbv,
    coalesce(var.product_class, module.info.product_class),
    var.type,
    var.role,
    var.counter
  ))
}

output "location" {
  description = "The location of the resource group."
  value       = module.info.location
}

output "tags" {
  description = "The tags of the resource group."
  value       = module.info.tags
}