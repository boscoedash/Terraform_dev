
variable "resource_group_name" {
  description = "The name of the resource group the resource to be named is being created in."
  type        = string
}

variable "product_class" {
  description = "The product class the resource to be named is being created in.  If not provided will be detected from the subscription."
  type        = string
  default     = null
}

variable "type" {
  type        = string
  description = "The three-letter code of the type of resource being created."
}

variable "role" {
  description = "The description of what this resource is for."
  type        = string
}

variable "counter" {
  description = "A counter that can be incremented for de-duplication if there are multipule resources for the same role."
  type        = number
  default     = 1
}
