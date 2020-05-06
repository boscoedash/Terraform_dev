provider "azurerm" {
  features {}
}

resource "azurerm_template_deployment" "template_deployment" {
  name                = "sqlmitestbl1"
  resource_group_name = var.resource_group_name
  deployment_mode     = var.deployment_mode == null ? "Incremental" : var.deployment_mode
  #parameters          = var.parameters
  template_body       = file("./Modules/SQLManagedInstance/SQLManagedInstance.json")
  parameters = {
    "name"                       = "sql-mi-test"
    "location"                   = "SouthCentralUS"
    "tags"                       = ""
    "skuName"                    = "GP_Gen5"
   // "skuSize"                    = ""
    //"skuTier"                    = "GeneralPurpose"
    "managedInstanceCreateMode"  = "default"
    "administratorLogin"         = "xadmin"
    "administratorLoginPassword" = "!A@S3d4f5g6h7j8k"
    "subnetId"                   = "/subscriptions/1d46d15f-334e-45e7-9b3d-93f04450e4e2/resourceGroups/SQL-MI-TEST/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/default"
    "licenseType"                = "LicenseIncluded"
    "vCores"                     = 8
    "storageSizeInGB"            = 256
    "collation"                  = "SQL_Latin1_General_CP1_CI_AS"
    #"dnsZonePartner"             = ""
    "publicDataEndpointEnabled"  = false
    #"sourceManagedInstanceId"    = ""
    #"restorePointInTime"         = ""
    #"proxyOverride"              = "proxy"
    #"timezoneId"                 = "UTC"
    #"instancePoolId"             = ""
   # "minimalTlsVersion"          = ""
  }
}
