provider "azurerm" {
  features {}
}

module "ResourceGroup" {
  source    = "./Modules/ResourceGroup"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}

module "VirtualNetwork" {
  source                        = "./Modules/VirtualNetwork"
  virtual_network_name          = var.virtual_network_name
  resource_group_name           = var.resource_group_name
  resource_group_location       = var.resource_group_location
  virtual_network_address_space = var.virtual_network_address_space
}

module "Subnet" {
  source               = "./Modules/Subnet"
  subnet_name          = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.VirtualNetwork.virtual_network_name
  subnet_address_space = var.subnet_address_space
}

module "PublicIP" {
  source                         = "./Modules/PublicIP"
  public_ip_name                 = var.public_ip_name
  resource_group_name            = var.resource_group_name
  resource_group_location        = var.resource_group_location
  public_ip_allocation_method    = var.public_ip_allocation_method
}

module "ApplicationGateway" {
  source                       = "./Modules/ApplicationGateway"
  application_gateway_name     = var.application_gateway_name
  resource_group_name          = var.resource_group_name
  resource_group_location      = var.resource_group_location
  virtual_network_name         = module.VirtualNetwork.virtual_network_name
  subnet_id                    = module.Subnet.subnet_id
  public_ip_address_id         = module.PublicIP.public_ip_address_id
  application_gateway_sku_name = var.application_gateway_sku_name
  application_gateway_sku_tier = var.application_gateway_sku_tier
  Gateway_IP_Config            = var.Gateway_IP_Config
  backend_address_pools        = var.backend_address_pools
  backend_http_settings        = var.backend_http_settings
  http_listeners               = var.http_listeners
  request_routing_rules        = var.request_routing_rules
  probes                       = var.probes
  /*
  url_path_map                 = var.url_path_map
  redirect_configurations      = var.redirect_configurations
  rewrite_rule_set             = var.rewrite_rule_set
  */
}
