provider "azurerm" {
  features {}
}


module "naming" {
  source      = "../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "sqlmi"
}

module "sql_managed_instance_arm_template" {
  source      = "../ARMTemplateDeployment"
  name                = lower(module.naming.name)
  resource_group_name = var.resource_group_name
  deployment_mode     = var.deployment_mode == null ? "Incremental" : var.deployment_mode
  template_file       = var.template_file
  parameters_file     = var.parameters_file == null ? "" : var.parameters_file
  parameters = {
    "name"                       = lower(module.naming.name)
    "location"                   = local.location
    "tags"                       = local.tags
    "skuName"                    = var.skuName
    "skuSize"                    = var.skuSize == null ? "" : var.skuSize
    "skuTier"                    = var.skuTier == null ? "Basic" : var.skuTier
    "managedInstanceCreateMode"  = var.managedInstanceCreateMode == null ? "default" : var.managedInstanceCreateMode
    "administratorLogin"         = var.administratorLogin
    "administratorLoginPassword" = var.administratorLoginPassword
    "subnetId"                   = var.subnetId
    "licenseType"                = var.licenseType == null ? "LicenseIncluded" : var.licenseType
    "vCores"                     = var.vCores == null ? 16 : var.vCores
    "storageSizeInGB"            = var.storageSizeInGB ? 32 : var.storageSizeInGB
    "collation"                  = var.collation == null ? "SQL_Latin1_General_CP1_CI_AS" : var.collation
    "dnsZonePartner"             = var.dnsZonePartner == null ? "" : var.dnsZonePartner
    "publicDataEndpointEnabled"  = var.publicDataEndpointEnabled == null ? false : var.publicDataEndpointEnabled
    "sourceManagedInstanceId"    = var.sourceManagedInstanceId == null ? "" : var.sourceManagedInstanceId
    "restorePointInTime"         = var.restorePointInTime == null ? "" : var.restorePointInTime
    "proxyOverride"              = var.proxyOverride == null ? 
    "timezoneId"                 = var.timezoneId == null ? "UTC" : var.timezoneId
    "instancePoolId"             = var.instancePoolId == null ? "" : var.instancePoolId
    "minimalTlsVersion"          = var.minimalTlsVersion == null ? "" : var.instancePoolId
  }
}