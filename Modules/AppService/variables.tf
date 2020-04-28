variable "description" {
  type        = string
  description = "The description of the resource for naming."
}

variable "counter" {
  type    = number
  default = 1
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the App Service"
}

variable "tags" {
  type        = map
  description = "A key-value pair of tags."
}

variable "app_service_plan_id" {
  type        = string
  description = "The ID of the App Service Plan within which to create this App Service."
}

variable "client_affinity_enabled" {
  type        = bool
  description = "Should the App Service send session affinity cookies, which route client requests in the same session to the same instance?"
}

variable "client_cert_enabled" {
  type        = bool
  description = "A key-value pair of App Settings."
}

variable "enabled" {
  type        = bool
  description = "Is the App Service Enabled?"
}

variable "https_only" {
  type        = bool
  description = "Can the App Service only be accessed via HTTPS? Defaults to false."
}

variable "logs_map" {
  type        = map
  description = "Map of log data"
}

variable "site_config_map" {
  type        = map
  description = "Map of site config data"
}

variable "site_config_cors_map" {
  type        = map
  description = "Map of cors data"
}

variable "identity_map" {
  type        = map
  description = "Map of identity data"
}

variable "app_settings_map" {
  type        = map
  description = "Map of app settings"
}

variable "auth_settings_map" {
  type        = map
  description = "Map of authentication settings data"
}

variable "active_directory_map" {
  type        = map
  description = "Map of active directory data"
}

variable "storage_account_map" {
  type        = map
  description = "Map of storage acocunt data"
}

variable "backup_map" {
  type        = map
  description = "Map of backup data"
}

variable "schedule_map" {
  type        = map
  description = "Map of backup schedule data"
}

variable "connection_string_map" {
  type        = map
  description = "Map of connection string data"
}

variable "ip_restriction_map" {
  type        = map
  description = "Map of ip restriction data"
}