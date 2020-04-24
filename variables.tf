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

variable "Gateway_IP_Config" {
  default     = ""
  description = "Name of the App Gateway PIP."
}
variable "backend_address_pools" {
  description = "List of backend address pools."
  default     = [
      {
        name         = "be-pool-01"
        ip_addresses = ["127.0.0.1"]
        fqdns        = ["vm@contoso.com"]
      }
  ]
}
variable "backend_http_settings" {
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
variable "http_listeners" {
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
        #url_path_map_name          = "Path map 1"
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
variable "probes" {
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
/*
variable "url_path_map" {
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
variable "redirect_configurations" {
  description = "Path Based Redirect Configurations."
  default  = [
        {
            name                   = "Redirect Configuration 1"
            redirect_type          = "Permanent" 
            target_listener_name   = ""
            target_url             = "http://contoso.com"
            include_path           = true
            include_query_string   = true
        }
  ]
}
variable "rewrite_rule_set" {
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
*/