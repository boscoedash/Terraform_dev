module "location-info" {
  source   = "../location-name"
  location = var.location
}

data "azurerm_subscription" "sub" {}

