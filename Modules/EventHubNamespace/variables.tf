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

variable "sku" {
  type        = string
  description = "Defines which tier to use. Valid options are Basic and Standard."
}

variable "capacity" {
  type        = number
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace. Valid values range from 1 - 20."
}

variable "auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace?"
}

variable "maximum_throughput_units" {
  type        = number
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20."
}

variable "network_rulesets_map" {
  type        = map
  description = "Map of Network Rule Set Data."
}
