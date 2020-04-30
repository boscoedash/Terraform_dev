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

variable "template_file" {
  type        = string
  description = "Path to ARM template"
}

variable "parameters_file" {
  type        = string
  description = "Path to ARM Teplate parameters"
}