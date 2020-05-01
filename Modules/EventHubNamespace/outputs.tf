output "id" {
  value = azurerm_eventhub_namespace.event_hub_namespace.id
}

output "default_primary_connection_string" {
  value = azurerm_eventhub_namespace.event_hub_namespace.default_primary_connection_string
}

output "default_secondary_connection_string" {
  value = azurerm_eventhub_namespace.event_hub_namespace.default_secondary_connection_string
}

output "default_primary_key" {
  value = azurerm_eventhub_namespace.event_hub_namespace.default_primary_key
}

output "default_secondary_key" {
  value = azurerm_eventhub_namespace.event_hub_namespace.default_secondary_key
}