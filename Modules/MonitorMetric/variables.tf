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

variable "scopes" {
  type        = list
  description = "A set of strings of resource IDs at which the metric criteria should be applied."
}

variable "enabled" {
  type        = bool
  description = "Should this Metric Alert be enabled? Defaults to true."
}

variable "auto_mitigate" {
  type        = bool
  description = "Should the alerts in this Metric Alert be auto resolved? Defaults to true."
}

variable "alert_description" {
  type        = string
  description = "The description of this Metric Alert.."
}

variable "frequency" {
  type        = string
  description = "The evaluation frequency of this Metric Alert, represented in ISO 8601 duration format. Possible values are PT1M, PT5M, PT15M, PT30M and PT1H. Defaults to PT1M."
}

variable "severity" {
  type        = number
  description = "The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3."
}

variable "window_size" {
  type        = string
  description = "The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than frequency. Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. Defaults to PT5M."
}

variable "action_map" {
  type        = map
  description = "Map of Action data"
}

variable "criteria_map" {
  type        = map
  description = "Map of Criteria Data"
}

variable "dimension_map" {
  type        = map
  description = "Map of Dimension data"
}
