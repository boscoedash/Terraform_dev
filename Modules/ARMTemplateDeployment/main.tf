# Did Not include Naming Module because there is no convention for ARM templates
resource "azurerm_template_deployment" "template_deployment" {
  name                = var.name
  resource_group_name = var.resource_group_name
  deployment_mode     = var.deployment_mode == null ? "Incremental" : var.deployment_mode
  template_body       = file(var.template_file)
  parameters_body     = var.parameters_body == null ? "" : var.parameters_body
}
