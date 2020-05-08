module "naming" {
  source      = "../../../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "sqlmi"
}

module "sql_managed_instance_arm_template" {
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
        "skuName": {
          "defaultValue": ${var.skuSize == null ? "" : var.skuSize}
        },
        "skuName": {
          "defaultValue": ${var.skuTier == null ? "" : var.skuTier}
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
          "defaultValue": ${var.dnsZonePartner == null ? "" : var.dnsZonePartner}
        },
        "publicDataEndpointEnabled": {
          "defaultValue": ${var.publicDataEndpointEnabled == null ? false : var.publicDataEndpointEnabled}
        },
        "sourceManagedInstanceId": {
          "defaultValue": ${var.sourceManagedInstanceId == null ? "" : var.sourceManagedInstanceId}
        },
        "restorePointInTime": {
          "defaultValue": ${var.restorePointInTime == null ? "" : var.restorePointInTime}
        },
        "proxyOverride": {
          "defaultValue": ${var.proxyOverride == null ? "" : var.proxyOverride}
        },
        "timezoneId": {
          "defaultValue": ${var.timezoneId == null ? "" : var.timezoneId}
        },
        "instancePoolId": {
          "defaultValue": ${var.instancePoolId == null ? "" : var.instancePoolId}
        },
        "minimalTlsVersion": {
          "defaultValue": ${var.minimalTlsVersion == null ? "" : var.minimalTlsVersion}
        }
    }
  }
  PARAMETERS
}