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

module "external_ase_arm_template" {
  source      = "../ARMTemplateDeployment"
  name                = lower(module.naming.name)
  resource_group_name = var.resource_group_name
  deployment_mode     = var.deployment_mode == null ? "Incremental" : var.deployment_mode
  template_body       = file(var.template_file)
  parameters = {
    "aseName"                             = lower(module.naming.name)
    "aseLocation"                         = local.location
    "existingVirtualNetworkName"          = var.existingVirtualNetworkName
    "existingVirtualNetworkResourceGroup" = var.existingVirtualNetworkResourceGroup
    "subnetName"                          = var.subnetName
    "internalLoadBalancingMode"           = var.internalLoadBalancingMode == null ? 0 : var.internalLoadBalancingMode
    "dnsSuffix"                           = var.dnsSuffix
    "tags"                                = local.tags
  }
}
