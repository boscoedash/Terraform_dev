variable "location" {
  type        = string
  description = "The Azure region that the resoruce will be created in."
}

variable "type" {
  type        = string
  description = "The two to three letter code of the type of resource being created."
}

variable "description" {
  description = "The description of what this resource is for."
  type        = string
}

variable "counter" {
  description = "A counter that can be incremented for de-duplication if there are multipule resources for the same role."
  type        = number
}
