module "naming" {
  source      = "../../../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "eh"
}

locals {
  capture_description_map = var.capture_description_map == null ? {} : var.capture_description_map
  destination_map         = var.destination_map == null ? {} : var.destination_map
}

resource "azurerm_eventhub" "event_hub" {
  name                = lower(module.naming.name)
  resource_group_name = var.resource_group_name
  namespace_name      = var.namespace_name
  partition_count     = var.partition_count
  message_retention   = var.message_retention

  capture_description {
    enabled             = lookup(local.capture_description_map, "enabled")
    encoding            = lookup(local.capture_description_map, "encoding")
    interval_in_seconds = lookup(local.capture_description_map, "interval_in_seconds", 300)
    size_limit_in_bytes = lookup(local.capture_description_map, "size_limit_in_bytes", 314572800)
    skip_empty_archives = lookup(local.capture_description_map, "skip_empty_archives", false)

    destination {
        name                = lookup(local.destination_map, "name")
        archive_name_format = lookup(local.destination_map, "archive_name_format")
        blob_container_name = lookup(local.destination_map, "blob_container_name")
        storage_account_id  = lookup(local.destination_map, "storage_account_id")
    }
  }
}