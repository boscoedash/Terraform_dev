output "name" {
  description = "The generated name"
  value = lower(format("%s-%s-%s-%s-%s%02d",
    coalesce(var.product_class, module.info.product_class),
    module.info.location_short_abbv,
    module.info.env_short_name,
    var.role,
    var.type,
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