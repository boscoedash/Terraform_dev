module "naming" {
  source      = "../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "sqlmi"
}

module "azurerm_template_deployment" {
  source      = "../ARMTemplateDeployment"
  name                = "sqlmitestbl01"
  resource_group_name = var.resource_group_name
  deployment_mode     = var.deployment_mode == null ? "Incremental" : var.deployment_mode
  template_file       = var.template_file
  parameters_body     = <<PARAMETERS
  {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
      "name": {
          "defaultValue": ${lower(module.naming.name)}
        },
        "tags": {
          "defaultValue": ${local.tags}
        },
        "skuName": {
          "defaultValue": ${var.skuName}
        },
        "location": {
          "defaultValue": ${local.location}
        },
        "managedInstanceCreateMode": {
          "defaultValue": ${var.managedInstanceCreateMode}
        },
        "administratorLogin": {
          "defaultValue": ${var.administratorLogin}
        },
        "administratorLoginPassword": {
          "defaultValue": ${var.administratorLoginPassword}
        },
        "subnetId": {
          "defaultValue": ${var.subnetId}
        },
        "licenseType": {
          "defaultValue": ${var.licenseType}
        },
        "vCores": {
          "defaultValue": ${var.vCores}
        },
        "storageSizeInGB": {
          "defaultValue": ${var.storageSizeInGB}
        },
        "collation": {
          "defaultValue": ${var.collation}
        },
        "dnsZonePartner": {
          "defaultValue": ${var.dnsZonePartner}
        },
        "publicDataEndpointEnabled": {
          "defaultValue": ${var.publicDataEndpointEnabled}
        },
        "sourceManagedInstanceId": {
          "defaultValue": ${var.sourceManagedInstanceId}
        },
        "restorePointInTime": {
          "defaultValue": ${var.restorePointInTime}
        },
        "proxyOverride": {
          "defaultValue": ${var.proxyOverride}
        },
        "timezoneId": {
          "defaultValue": ${var.timezoneId}
        },
        "instancePoolId": {
          "defaultValue": ${var.instancePoolId}
        },
        "minimalTlsVersion": {
          "defaultValue": ${var.minimalTlsVersion}
        }
    }
  }
  PARAMETERS
}