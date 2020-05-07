module "naming" {
  source      = "../../../naming/standard-name"
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
  template_file       = var.template_file
  parameters_file     = var.parameters_file == null ? "" : var.parameters_file
  parameters_body     = <<PARAMETERS
  {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
      "aseName": {
        "defaultvalue": ${lower(module.naming.name)}
      },
      "aseLocation": {
        "defaultValue": ${local.location}
      },
      "existingVirtualNetworkName": {
        "defaultValue": ${var.existingVirtualNetworkName}
      },
      "existingVirtualNetworkResourceGroup": {
        "defaultValue": ${var.existingVirtualNetworkResourceGroup}
      },
      "subnetName": {
        "defaultValue": ${var.subnetName}
      },
      "tags": {
        "defaultValue": ${local.tags}
      },
      "internalLoadBalancingMode": {
        "defaultValue": ${var.internalLoadBalancingMode == null ? 3 : var.internalLoadBalancingMode}
      },
      "dnsSuffix": {
        "defaultValue": ${var.dnsSuffix}
      }
    }
  }
  PARAMETERS
}
