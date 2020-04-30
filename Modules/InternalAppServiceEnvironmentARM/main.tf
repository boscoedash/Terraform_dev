provider "azurerm" {
  features {}
}

module "naming" {
  source      = "../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "ase"
}

module "internal_ase_arm_template" {
  source      = "../ARMTemplateDeployment"
  name                = lower(module.naming.name)
  resource_group_name = var.resource_group_name
  deployment_mode     = var.deployment_mode == null ? "Incremental" : var.deployment_mode
  template_body       = var.template_file
  parameters_file     = var.parameters_file == null ? "" : var.parameters_file
  parameters = {
    "aseName"                             = lower(module.naming.name)
    "aseLocation"                         = local.location
    "existingVirtualNetworkName"          = var.existingVirtualNetworkName
    "existingVirtualNetworkResourceGroup" = var.existingVirtualNetworkResourceGroup
    "subnetName"                          = var.subnetName
    "internalLoadBalancingMode"           = var.internalLoadBalancingMode == null ? 3 : var.internalLoadBalancingMode
    "dnsSuffix"                           = var.dnsSuffix
    "tags"                                = local.tags
  }
}
