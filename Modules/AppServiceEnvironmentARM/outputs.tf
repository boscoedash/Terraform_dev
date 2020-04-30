output "storageAccountName" {
  value = azurerm_template_deployment.example.outputs["storageAccountName"]
}