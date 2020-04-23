variable "resource_group_name" {
  description = "Name of the resource group to place App Gateway in."
}
variable "resource_group_location" {
  description = "Location of the resource group to place App Gateway in."
}
variable "public_ip_name" {
  description = "Name of the App Gateway PIP."
}
variable "public_ip_allocation_method" {
  description = "Is the public IP address of the App Gateway static?"
  default     = "Dynamic"
}
