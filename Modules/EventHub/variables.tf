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

variable "namespace_name" {
  type        = string
  description = "Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created."
}

variable "partition_count" {
  type        = number
  description = "Specifies the current number of shards on the Event Hub. Changing this forces a new resource to be created."
}

variable "message_retention" {
  type        = number
  description = "Specifies the number of days to retain the events for this Event Hub. Needs to be between 1 and 7 days; or 1 day when using a Basic SKU for the parent EventHub Namespace."
}

variable "capture_description_map" {
  type        = map
  description = "Map of capture data."
}

variable "destination_map" {
  type        = map
  description = "Map of capture destination data."
}