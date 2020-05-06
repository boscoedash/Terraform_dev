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

variable "parameters" {
  type        = map
  description = "Key value pairs of ARM Teplate parameters"
}
