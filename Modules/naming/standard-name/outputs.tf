output "name" {
  description = "The generated name"
  value = lower(format("%s-%s-%s-%s%02d",
    data.azurerm_subscription.sub.display_name,
    module.location-info.short_abbv,
    var.type,
    var.description,
    var.counter
  ))
}