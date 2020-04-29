variable "location" {
  type        = string
  description = "The ASE location."
}

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

variable "subnet_id" {
  type        = string
  description = "The kind of App Service plan to create.  i.e. Windows, Linux, FunctionAll."
}

variable "pricing_tier" {
  type        = string
  description = "The pricing tier to use for the plan."
}

variable "front_end_scale_factor" {
  type        = number
  description = "The ASE scale factor."
}