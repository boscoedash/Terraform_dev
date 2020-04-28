
data "azurerm_subscription" "sub" {
}

locals {
  parts         = regex("^([A-Za-z]+)-([A-Za-z0-9]{3})([A-Za-z0-9]+)", data.azurerm_subscription.sub.display_name)
  env           = upper(local.parts[0])
  product_class = upper(local.parts[1])
  description   = upper(local.parts[2])

  mapping = {
    LAB : "L",
    PRD : "P",
    SBX : "B",
    TST : "T",
    DEV : "D",
    DQA : "D",
    QAT : "Q",
    STG : "S",
    ISO : "I"
  }

  short_env = local.mapping[local.env]
}