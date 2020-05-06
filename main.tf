provider "azurerm" {
  features {}
}
/*
module "ResourceGroup" {
  source    = "./Modules/ResourceGroup"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}

module "NSG" {
  source                         = "./Modules/NSG"
  resource_group_name     = var.resource_group_name
  securityrules = var.securityrules
  description = "nsg"
  subnet_id = ""
  depends_on = [
    module.ResourceGroup
  ]
}

module "RouteTable" {
  source                         = "./Modules/RouteTable"
  depends_on = [
    module.ResourceGroup
  ]
}

module "VirtualNetwork" {
  source                        = "./Modules/VirtualNetwork"
  virtual_network_name          = var.virtual_network_name
  resource_group_name           = var.resource_group_name
  resource_group_location       = var.resource_group_location
  virtual_network_address_space = var.virtual_network_address_space
  depends_on = [
    module.ResourceGroup,
    module.RouteTable,
    module.NSG
  ]
}

module "Subnet" {
  source               = "./Modules/Subnet"
  subnet_name          = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.VirtualNetwork.virtual_network_name
  subnet_address_space = var.subnet_address_space
  depends_on = [
    module.ResourceGroup,
    module.VirtualNetwork
  ]
}
*/

module "sql_managed_instance_arm_template" {
  source              = "./Modules/SQLManagedInstance"
  description         = var.description
  tags                = var.tags
  resource_group_name = var.resource_group_name
  deployment_mode     = "incremental"
  template_file       = var.template_file
  parameters          = var.parameters
  parameters_file     = {}
}

/*
module "PublicIP" {
  source                         = "./Modules/PublicIP"
  public_ip_name                 = var.public_ip_name
  resource_group_name            = var.resource_group_name
  resource_group_location        = var.resource_group_location
  public_ip_allocation_method    = var.public_ip_allocation_method
}

module "ApplicationGateway" {
  source                           = "./Modules/ApplicationGateway"
  resource_group_name             = var.resource_group_name
  tags                            = var.application_gateway_tags
  description                     = var.application_gateway_description
  name                            = var.application_gateway_name
  counter                         = var.counter
  sku_name                        = var.application_gateway_sku_name
  sku_tier                        = var.application_gateway_sku_tier
  sku_capacity                    = var.application_gateway_sku_capacity
  autoscale_min_capacity          = var.application_gateway_autoscale_min_capacity
  autoscale_max_capacity          = var.application_gateway_autoscale_max_capacity
  gateway_ip_config_map           = var.application_gateway_gateway_ip_config_map
  ssl_policy_type                 = var.application_gateway_ssl_policy_type
  ssl_min_protocol_version        = var.application_gateway_ssl_min_protocol_version
  ssl_cipher_suites_max_v2        = var.application_gateway_ssl_cipher_suites_max_v2
  enable_http2                    = var.application_gateway_enable_http2
  backend_address_pools_map       = var.application_gateway_backend_address_pools
  backend_http_setting_map        = var.application_gateway_backend_http_settings
  frontend_ip_config_map          = var.application_gateway_frontend_ip_config_map
  frontend_port_map               = var.application_gateway_frontend_ip_config_map
  http_listener_map               = var.application_gateway_http_listener_map
  request_routing_rule_map        = var.application_gateway_request_routing_rules
  identity_ids                    = var.application_gateway_identity_ids
  identity_type                   = var.application_gateway_identity_type
  zones                           = var.application_gateway_zones
  authentication_certificate_map  = var.application_gateway_authentication_certificate_map
  trusted_root_certificate_map    = var.application_gateway_trusted_root_certificate_map
  ssl_certificate_map             = var.application_gateway_ssl_certificate_map
  probe_map                       = var.application_gateway_probe_map
  url_path_map_map                = var.application_gateway_url_path_map
  custom_error_configuration_map  = var.application_gateway_custom_error_configuration_map
  redirect_configuration_name_map = var.application_gateway_redirect_configurations
  rewrite_rule_set_map            = var.application_gateway_rewrite_rule_set
}
*/
