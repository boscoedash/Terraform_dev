module "naming" {
  source      = "../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "ase"
}

module "ARMTemplateDeployment" {
  name                = lower(module.naming.name)
  resource_group_name = var.resource_group_name
  deployment_mode     = var.deployment_mode == null ? "Incremental" : var.deployment_mode
  template_body       = file(var.template_file)
  parameters_body     = file(var.parameters_file)

  parameters = {
    "tags" = local.tags
  }
}
