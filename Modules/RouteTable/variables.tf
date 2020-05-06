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

variable "counter" {
  type    = number
  default = 1
}

variable "disable_bgp_route_propagation" {
  type        = bool
  description = "The public IP SKU (basic or standard)"
  default     = false
}

variable "routeslist" {
  type        = list
  description = "List of route Objects."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to associate route table with."
  default     = null
}