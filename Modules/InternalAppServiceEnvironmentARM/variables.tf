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

variable "deployment_mode" {
  type        = string
  description = "Incremental or Complete"
}

variable "existingVirtualNetworkName" {
  type        = string
  description = "The name of the virtual network associated with the ASE"
}

variable "existingVirtualNetworkResourceGroup" {
  type        = string
  description = "The name of the virtual network Resource Group"
}

variable "subnetName" {
  type        = string
  description = "The name of the ASE Subnet"
}

variable "internalLoadBalancingMode" {
  type        = number
  description = "0 = public VIP only, 1 = only ports 80/443 are mapped to ILB VIP, 2 = only FTP ports are mapped to ILB VIP, 3 = both ports 80/443 and FTP ports are mapped to an ILB VIP."
}

variable "dnsSuffix" {
  type        = string
  description = "Used *only* when deploying an ILB enabled ASE.  Set this to the root domain associated with the ASE.  For example: contoso.com."
}

variable "tags" {
  type        = map
  description = "A key-value pair of tags."
}