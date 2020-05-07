variable "name" {
  type        = string
  description = "The name of the deployment"
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
  description = "pecifies the mode that is used to deploy resources. This value could be either Incremental or Complete. Note that you will almost always want this to be set to Incremental otherwise the deployment will destroy all infrastructure not specified within the template, and Terraform will not be aware of this."
}

variable "parameters_body" {
  type        = string
  description = "override parameters formatted as a json snippet"
}