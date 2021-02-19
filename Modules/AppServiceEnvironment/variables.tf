variable "app_service_environment_name" {
  type        = string
  description = "The ASE name."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the App Service"
}

variable "subnet_id" {
  type        = string
  description = "The kind of App Service plan to create.  i.e. Windows, Linux, FunctionAll."
}

variable "ase_pricing_tier" {
  type        = string
  description = "The pricing tier to use for the plan."
  default     = "I1"
}

variable "front_end_scale_factor" {
  type        = number
  description = "The ASE scale factor."
  default     = 15
}

variable "internal_load_balancing_mode" {
  type        = string
  description = "Specifies which endpoints to serve internally in the Virtual Network for the App Service Environment. Possible values are None, Web, Publishing and combined value Web, Publishing. Defaults to None."
  default     = "None"
}

variable "allowed_user_ip_cidrs" {
  type        = list
  description = "Allowed user added IP ranges on the ASE database. Use the addresses you want to set as the explicit egress address ranges"
  default     = []
}
