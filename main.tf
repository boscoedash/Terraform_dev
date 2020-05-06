provider "azurerm" {
  features {}
}

resource "azurerm_template_deployment" "template_deployment" {
  name                = "sqlmitestbl1"
  resource_group_name = var.resource_group_name
  deployment_mode     = var.deployment_mode == null ? "Incremental" : var.deployment_mode
  parameters          = var.parameters
  template_body       = file("./Modules/SQLManagedInstance/SQLManagedInstance.json")
}
