variable "resource_group_name" {
  description = "Name of the resource group to place App Gateway in."
}
variable "resource_group_location" {
  description = "Location of the resource group to place App Gateway in."
}
variable "application_gateway_name" {
  description = "Name of App Gateway"
}
variable "virtual_network_name" {
  description = "Name of App Gateway Virtual Network"
}
variable "subnet_id" {
  description = "Subnet ID"
}
variable "public_ip_address_id" {
  description = "Public IP Address ID"
}
variable "Gateway_IP_Config" {
  description = "Name of the App Gateway PIP."
}
variable "backend_address_pools" {
  description = "List of backend address pools."
  type = list(object({
    name         = string
    ip_addresses = list(string)
    fqdns        = list(string)
  }))
}
variable "backend_http_settings" {
  description = "List of backend HTTP settings."
  type = list(object({
    name                                = string
    has_cookie_based_affinity           = bool
    path                                = string
    port                                = number
    is_https                            = bool
    request_timeout                     = number
    probe_name                          = string
    pick_host_name_from_backend_address = bool
  }))
}
variable "http_listeners" {
  description = "List of HTTP listeners."
  type = list(object({
    name     = string
    is_https = bool
  }))
}
variable "request_routing_rules" {
  description = "Request routing rules to be used for listeners."
  type = list(object({
    name                       = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
    is_path_based              = bool
    url_path_map_name          = string
  }))
}
variable "is_public_ip_allocation_static" {
  description = "Is the public IP address of the App Gateway static?"
  default     = false
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
  default     = []
  type = list(object({
    name                                      = string
    path                                      = string
    is_https                                  = bool
    pick_host_name_from_backend_http_settings = bool
  }))
}

variable "url_path_map" {
  description                        = "URL path maps associated to path-based rules."
  default                            = []
  type = list(object({
    name                          = string
    path_rules = list(object({
      name                        = string
      backend_address_pool_name   = string
      backend_http_settings_name  = string
      redirect_configuration_name = string
      rewrite_rule_set_name       = string
      paths                       = list(string)
    }))
  }))
}

variable "redirect_configurations" {
  description = "Path Based Redirect Configurations."
  type = list(object({
    name                   = string
    redirect_type          = string
    target_listener_name   = string
    target_url             = string
    include_path           = string
    include_query_string   = string
  }))
}

variable "rewrite_rule_set" {
  description = "Header Rewrite"
  type = list(object({
    name         = string
    rewrite_rule = list(object({
      name          = string
      rule_sequence = number
      
      condition     = list(object({
            variable    = string
            pattern     = string
            ignore_case = bool
            negate      = bool
        }))
      request_header_configuration  = list(object({
            header_name  = string
            header_value = string
        }))
      response_header_configuration = list(object({
            header_name  = string
            header_value = string
        }))
        */
    }))
  }))
}
