 module "naming" {
  source      = "../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "route"
}

resource "azurerm_route_table" "routetable" {
  name                          = module.naming.name
  resource_group_name           = var.resource_group_name
  location                      = local.location
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
  route                         = var.routeslist
  tags                          = local.tags

  # route {
  #         name                    = "actualroute"
  #     address_prefix          = "0.0.0.0/0"
  #     next_hop_type           = "None"
  #     next_hop_in_ip_address  = null
  # }
  # route {
  #         name                    = "actualroute2"
  #     address_prefix          = "10.0.0.0/32"
  #     next_hop_type           = "None"
  #     next_hop_in_ip_address  = null
  # }

}

resource "azurerm_subnet_route_table_association" "routetable_assoc" {
  route_table_id = azurerm_route_table.routetable.id
  subnet_id      = var.subnet_id
}
