
output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "nsg_assoc_id" {
  value = azurerm_subnet_network_security_group_association.nsg_assoc.id
}

output "nsg_flow_log_id" {
  value = azurerm_network_watcher_flow_log.nsg_flow_log.id
}

output "snet_suffix" {
  value = "${var.description}${var.counter}"
}