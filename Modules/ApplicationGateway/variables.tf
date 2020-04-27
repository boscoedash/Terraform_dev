variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to create the storage account under."
}

variable "tags" {
  type        = map(string)
  description = "The tags to assign to the resources.  Defaults to the tags of the containing resource group."
  default     = null
}

variable "description" {
  type        = string
  description = "The description of the resource for naming."
}

variable "name" {
  type        = string
  description = "The name of the application gateway."
}

variable "counter" {
  type    = number
  default = 1
}

variable "sku_name" {
  type        = string
  description = "The Name of the SKU to use for this Application Gateway."
  default     = "Standard_v2"
}

variable "sku_tier" {
  type        = string
  description = "The Tier of the SKU to use for this Application Gateway. "
  default     = "Standard_v2"
}

variable "sku_capacity" {
  type        = number
  description = "The Capacity of the SKU to use for this Application Gateway."
  default     = null
}

variable "autoscale_min_capacity" {
  type        = number
  description = "Minimum capacity for autoscaling. Accepted values are in the range 0 to 100."
  default     = 1
}

variable "autoscale_max_capacity" {
  type        = number
  description = "Maximum capacity for autoscaling. Accepted values are in the range 2 to 125."
  default     = 5
}

variable "ssl_policy_type" {
  type        = string
  description = "The Type of the Policy. Possible values are Predefined and Custom."
  default     = "Custom"
}

variable "ssl_min_protocol_version" {
  type        = string
  description = "The minimal TLS version."
  default     = "TLSv1_2"
}

variable "ssl_cipher_suites_max_v2" {
  type        = list
  description = "A List of accepted cipher suites."
  default = [
    "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
    #"TLS_RSA_WITH_AES_256_CBC_SHA256"
  ]
}

variable "enable_http2" {
  type        = bool
  description = "Is HTTP2 enabled on the application gateway resource?"
  default     = true
}

variable "backend_address_pool_map" {
  type        = map
  description = "Map of backend pools"
}

variable "backend_http_settings_map" {
  type        = map
  description = "Map of backend http settings"
}

variable "frontend_ip_config_map" {
  type        = map
  description = "Map of frontend IP Configs"
}

variable "frontend_port_map" {
  type        = map
  description = "Map of frontend ports"
}

variable "gateway_ip_config_map" {
  type        = map
  description = "Map of gateway ip configs"
}

variable "http_listener_map" {
  type        = map
  description = "Map of https listeners"
}

variable "request_routing_rule_map" {
  type        = map
  description = "Map of Request Routing Rules"
}

variable "identity_ids" {
  type        = list
  description = "Specifies a list with a single user managed identity id to be assigned to the Application Gateway."
}

variable "identity_type" {
  type        = string
  description = "The Managed Service Identity Type of this Application Gateway."
  default     = "UserAssigned"
}

variable "zones" {
  description = "A collection of availability zones to spread the Application Gateway over."
  default     = null
}

variable "authentication_certificate_map" {
  type        = map
  description = "Map of Authentication Certificates"
}

variable "trusted_root_certificate_map" {
  type        = map
  description = "Map of Trusted Root Certificates"
}

variable "ssl_certificate_map" {
  type        = map
  description = "Map of ssl certificates"
}

variable "probe_map" {
  type        = map
  description = "Map of probes"
}

variable "url_path_map_map" {
  type        = map
  description = "Map of url path maps"
}

variable "custom_error_configuration_map" {
  type        = map
  description = "Map of GLOBAL custom error configs, these can also be specified at an http listener level."
}

variable "rewrite_rule_set_map" {
  type        = map
  description = "Map rewrite rule sets"
}

variable "redirect_configuration_name_map" {
  type        = map
  description = "Map of redirect configurations"
}
