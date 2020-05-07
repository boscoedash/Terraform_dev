provider "azurerm" {
  features {}
}

module "sql_mi" {
  source = "./Modules/SQLManagedInstance"
  description = "sqlmi"
  counter = 1
  resource_group_name = "sql-mi-test"
  deployment_mode     = "Incremental"
  template_file = "./Modules/SQLManagedInstance/SQLManagedInstance.json"
  name                       = "sql-mi-test"
  skuName                    = "GP_Gen5"
  skuSize                    = ""
  skuTier                    = "GeneralPurpose"
  managedInstanceCreateMode  = "default"
  administratorLogin         = "xadmin"
  administratorLoginPassword = "A%%S3d4f5g6h7j8k"
  subnetId                   = "/subscriptions/1d46d15f-334e-45e7-9b3d-93f04450e4e2/resourceGroups/SQL-MI-TEST/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/default"
  licenseType                = "LicenseIncluded"
  vCores                     = 8
  storageSizeInGB            = 256
  collation                  = "SQL_Latin1_General_CP1_CI_AS"
  dnsZonePartner             = ""
  publicDataEndpointEnabled  = "false"
  sourceManagedInstanceId    = ""
  restorePointInTime         = ""
  proxyOverride              = "proxy"
  timezoneId                 = "UTC"
  instancePoolId             = ""
  minimalTlsVersion          = ""
}
