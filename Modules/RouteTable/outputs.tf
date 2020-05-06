output "subnets" {
  value = azurerm_route_table.routetable.subnets
}

output "routetable_id" {
  value = azurerm_route_table.routetable.id
}

output "routetable_assoc_id" {
  value = azurerm_subnet_route_table_association.routetable_assoc.id
}