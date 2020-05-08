variable "description" {
  type        = string
  description = "The description of the resource for naming."
}

variable "counter" {
  type    = number
  default = 1
}

variable "tags" {
  type    = map
  default = null
}

variable "deployment_mode" {
  type    = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the App Service"
}

variable "template_file" {
  type        = string
  description = "Path to ARM template"
}

variable "name" {
  type        = string
  description = "The name of the managed instance."
}

variable "skuName" {
  type        = string
  description = "The name of the SKU, typically, a letter + Number code, e.g. P3."
}

variable "skuSize" {
  type        = string
  description = "Size of the particular SKU"
}

variable "skuTier" {
  type        = string
  description = "The tier or edition of the particular SKU, e.g. Basic, Premium."
}

variable "managedInstanceCreateMode" {
  type        = string
  description = "Specifies the mode of database creation."
}

variable "administratorLogin" {
  type        = string
  description = "Administrator username for the managed instance. Can only be specified when the managed instance is being created (and is required for creation)."
}

variable "administratorLoginPassword" {
  type        = string
  description = "The administrator login password (required for managed instance creation)."
}

variable "subnetId" {
  type        = string
  description = "	Subnet resource ID for the managed instance."
}

variable "licenseType" {
  type        = string
  description = "The license type. Possible values are 'LicenseIncluded' (regular price inclusive of a new SQL license) and 'BasePrice' (discounted AHB price for bringing your own SQL licenses). - LicenseIncluded or BasePrice"
}

variable "vCores" {
  type        = number
  description = "	The number of vCores. Allowed values: 8, 16, 24, 32, 40, 64, 80."
}

variable "storageSizeInGB" {
  type        = number
  description = "Storage size in GB. Minimum value: 32. Maximum value: 8192. Increments of 32 GB allowed only."
}

variable "collation" {
  type        = string
  description = "Collation of the managed instance."
}

variable "dnsZonePartner" {
  type        = string
  description = "The resource id of another managed instance whose DNS zone this managed instance will share after creation."
}

variable "publicDataEndpointEnabled" {
  type        = bool
  description = "Whether or not the public data endpoint is enabled."
}

variable "sourceManagedInstanceId" {
  type        = string
  description = "The resource identifier of the source managed instance associated with create operation of this instance."
}

variable "restorePointInTime" {
  type        = string
  description = "Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database."
}

variable "proxyOverride" {
  type        = string
  description = "Connection type used for connecting to the instance. - Proxy, Redirect, Default"
}

variable "timezoneId" {
  type        = string
  description = "Id of the timezone. Allowed values are timezones supported by Windows."
}

variable "instancePoolId" {
  type        = string
  description = "The Id of the instance pool this managed server belongs to."
}

variable "minimalTlsVersion" {
  type        = string
  description = "Minimal TLS version. Allowed values: 'None', '1.0', '1.1', '1.2'"
}