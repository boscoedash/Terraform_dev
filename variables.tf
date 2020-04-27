variable "resource_group_name" {
  default     = "RG-GW"
  description = "Name of the resource group to place App Gateway in."
}
variable "resource_group_location" {
  default     = "South Central US"
  description = "Location of the resource group to place App Gateway in."
}
variable "application_gateway_name" {
  default     = "GW01"
  description = "Name of App Gateway"
}
variable "virtual_network_name" {
  default     = "vnet01"
  description = "Name of the vNet place App Gateway in."
}
variable "virtual_network_address_space" {
  default     = ["10.0.0.0/16"]
  description = "vNet Address Space."
}
variable "subnet_name" {
  default     = "subnet-gw01"
  description = "Name of the subnet place App Gateway in."
}
variable "subnet_address_space" {
  default     = "10.0.1.0/24"
  description = "vNet Address Space."
}
variable "public_ip_name" {
  default     = "gw01-pip"
  description = "Name of the App Gateway PIP."
}
variable "public_ip_allocation_method" {
  description = "Is the public IP address static?"
  default     = "Dynamic"
}
variable "application_gateway_description" {
  default     = "application-gateway"
  description = "Name of the App Gateway."
}
variable "application_gateway_name" {
  default     = "application-gateway"
  description = "Name of the App Gateway."
}
variable "application_gateway_frontend_ip_config_map" {
  default     = ""
  description = "Name of the App Gateway PIP."
}
variable "application_gateway_backend_address_pools" {
  description = "List of backend address pools."
  default     = [
      {
        name         = "be-pool-01"
        ip_addresses = ["127.0.0.1"]
        fqdns        = ["vm@contoso.com"]
      }
  ]
}
variable "application_gateway_backend_http_settings" {
  description = "List of backend HTTP settings."
  default     = [
      {
        name                                = "HTTP Settings 1"
        has_cookie_based_affinity           = false
        path                                = ""
        port                                = 80
        is_https                            = false
        request_timeout                     = 20
        probe_name                          = "probe1"
        pick_host_name_from_backend_address = false
      }
  ]
}
variable "application_gateway_http_listener_map" {
  description = "List of HTTP listeners."
  default     = [
      {
        name     = "http"
        is_https = false
      },
      {
        name     = "https"
        is_https = true
      },
  ]
}
variable "request_routing_rules" {
  description = "Request routing rules to be used for listeners."
  default     = [
      {
        name                       = "http to app1"
        http_listener_name         = "http"
        backend_address_pool_name  = "be-pool-01"
        backend_http_settings_name = "HTTP Settings 1"
        is_path_based              = true
        url_path_map_name          = "Path map 1"
      }
  ]
}
variable "application_gateway_sku_name" {
  description = "Name of App Gateway SKU."
  default     = "Standard_v2"
}
variable "application_gateway_sku_tier" {
  description = "Tier of App Gateway SKU."
  default     = "Standard_v2"
}
variable "application_gateway_probe_map" {
  description = "Health probes used to test backend health."
  default     = [
      {
        name                                      = "probe1"
        path                                      = "/*"
        is_https                                  = false
        pick_host_name_from_backend_http_settings = true
      }
    ]
}

variable "application_gateway_url_path_map" {
  description = "URL path maps associated to path-based rules."
  default     = [
    {
      name                             = "Path Map 1",
      path_rules = [
        {
            name                        = "Backend Rule",
            backend_address_pool_name   = "",
            backend_http_settings_name  = "",
            redirect_configuration_name = "Redirect Configuration 1",
            rewrite_rule_set_name       = "rewrite rule set 1",
            paths                       = ["",""]
        }
      ]
    }
  ]
}
variable "application_gateway_redirect_configurations" {
  description = "Path Based Redirect Configurations."
  default  = [
        {
            name                   = "Redirect Configuration 1"
            redirect_type          = "Permanent" 
            target_listener_name   = "http"
            target_url             = "http://contoso.com"
            include_path           = true
            include_query_string   = true
        }
  ]
}
variable "application_gateway_rewrite_rule_set" {
  description = "Header Rewrite"
  default     = [
    {
      name         = "rewrite rule set 1",
      rewrite_rule = [
        {
          name          = "rule1",
          rule_sequence = 100,
        
          condition     = [
            {
                variable    = "HTTP header",
                pattern     = "http://contoso-1.com",
                ignore_case = false,
                negate      = false
            }
          ],
          request_header_configuration  = [
            {
                header_name  = "X-Forwarded-Proto",
                header_value = ""
            }
          ],
          response_header_configuration = [
            {
                header_name  = "Location",
                header_value = "http://contoso.com"
            }
          ]
          
        }
      ]
    }
  ]
}


  tags                            = var.application_gateway_tags
  description                     = var.application_gateway_description
  counter                         = var.counter
  sku_name                        = var.application_gateway_sku_name
  sku_tier                        = var.application_gateway_sku_tier
  sku_capacity                    = var.application_gateway_sku_capacity
  autoscale_min_capacity          = var.application_gateway_autoscale_min_capacity
  autoscale_max_capacity          = var.application_gateway_autoscale_max_capacity
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