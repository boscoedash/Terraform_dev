module "naming" {
  source      = "../../../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "as"
}

locals {

  logs_map                        = var.logs_map == null ? {} : var.logs_map
  site_config_cors_map            = var.site_config_cors_map == null ? {} : var.site_config_cors_map
  identity_map                    = var.identity_map  == null ? {} : var.identity_map
  app_settings_map                = var.app_settings_map  == null ? {} : var.app_settings_map # "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.example.instrumentation_key} for app insghts"
  auth_settings_map               = var.auth_settings_map  == null ? {} : var.auth_settings_map
  active_directory_map            = var.active_directory_map  == null ? {} : var.active_directory_map
  storage_account_map             = var.storage_account_map  == null ? {} : var.storage_account_map
  backup_map                      = var.backup_map  == null ? {} : var.backup_map
  schedule_map                    = var.schedule_map  == null ? {} : var.schedule_map
  connection_string_map           = var.connection_string_map  == null ? {} : var.connection_string_map
  ip_restriction_map              = var.ip_restriction_map == null ? {} : var.ip_restriction_map
}

resource "azurerm_app_service" "app_service" {
  name                    = lower(module.naming.name)
  location                = local.location
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = var.app_service_plan_id
  app_settings            = local.app_settings_map
  client_affinity_enabled = var.client_affinity_enabled
  client_cert_enabled     = var.client_cert_enabled
  enabled                 = var.enabled
  https_only              = var.https_only
  tags                    = local.tags

  auth_settings {
    enabled                        = lookup(local.auth_settings_map, "enabled")
    additional_login_params        = lookup(local.auth_settings_map, "additional_login_params")
    allowed_external_redirect_urls = lookup(local.auth_settings_map, "allowed_external_redirect_urls")
    default_provider               = lookup(local.auth_settings_map, "default_provider")
    runtime_version                = lookup(local.auth_settings_map, "runtime_version")
    token_refresh_extension_hours  = lookup(local.auth_settings_map, "token_refresh_extension_hours")
    token_store_enabled            = lookup(local.auth_settings_map, "token_store_enabled")
    unauthenticated_client_action  = lookup(local.auth_settings_map, "unauthenticated_client_action")
    issuer                         = lookup(local.auth_settings_map, "isuer")

    active_directory {
      client_id         = lookup(local.active_directory_map, "client_id")
      client_secret     = lookup(local.active_directory_map, "client_secret")
      allowed_audiences = lookup(local.active_directory_map, "client_id")
    }
  }

  storage_account {
    name         = lookup(local.storage_account_map, "name")
    type         = lookup(local.storage_account_map, "type")
    account_name = lookup(local.storage_account_map, "account_name")
    share_name   = lookup(local.storage_account_map, "share_name")
    access_key   = lookup(local.storage_account_map, "access_key")
    mount_path   = lookup(local.storage_account_map, "mount_path", null)
  }

  backup {
    name                = lookup(local.backup_map, "name")
    enabled             = lookup(local.backup_map, "enabled")
    storage_account_url = lookup(local.backup_map, "storage_account_url", null) 

    schedule {
      frequency_interval       = lookup(local.schedule_map.value, "frequency_interval")
      frequency_unit           = lookup(local.schedule_map.value, "frequency_unit")
      keep_at_least_one_backup = lookup(local.schedule_map.value, "keep_at_least_one_backup")
      retention_period_in_days = lookup(local.schedule_map.value, "retention_period_in_days")
      start_time               = lookup(local.schedule_map.value, "start_time")
    }
  }

  connection_string {
    name  = lookup(local.connection_string_map, "name")
    type  = lookup(local.connection_string_map, "type")
    value = lookup(local.connection_string_map, "value")
  }

  logs {
    application_logs {
      azure_blob_storage {
        level             = lookup(local.logs_map.value.application_logs_map.value.azure_blob_storage.value, "level", "Off")
        sas_url           = lookup(local.logs_map.value.application_logs_map.value.azure_blob_storage.value, "sas_url")
        retention_in_days = lookup(local.logs_map.value.application_logs_map.value.azure_blob_storage.value, "retention_in_days", 30)
      }
    }

    http_logs {
      azure_blob_storage {
        sas_url           = lookup(local.logs_map.value.application_logs_map.value.azure_blob_storage.value, "sas_url")
        retention_in_days = lookup(local.logs_map.value.application_logs_map.value.azure_blob_storage.value, "retention_in_days", 30)
      }

      file_system {
        retention_in_mb   = lookup(local.logs_map.value.http_logs_map.value.file_system.value, "retention_in_mb")
        retention_in_days = lookup(local.logs_map.value.http_logs_map.value.file_system.value, "retention_in_days", 30)
      }
    }
  }

  site_config {
    always_on                 = lookup(var.site_config_map.value, "always_on", false)
    app_command_line          = lookup(var.site_config_map.value, "sapp_command_line")
    default_documents         = lookup(var.site_config_map.value, "default_documents")
    dotnet_framework_version  = lookup(var.site_config_map.value, "dotnet_framework_version", "v4.0")
    ftps_state                = lookup(var.site_config_map.value, "ftps_state")
    http2_enabled             = lookup(var.site_config_map.value, "http2_enabled", false)
    java_version              = lookup(var.site_config_map.value, "java_version")
    java_container            = lookup(var.site_config_map.value, "java_container")
    java_container_version    = lookup(var.site_config_map.value, "java_container_version")
    local_mysql_enabled       = lookup(var.site_config_map.value, "local_mysql_enabled")
    linux_fx_version          = lookup(var.site_config_map.value, "linux_fx_version")
    windows_fx_version        = lookup(var.site_config_map.value, "windows_fx_version")
    managed_pipeline_mode     = lookup(var.site_config_map.value, "managed_pipeline_version")
    min_tls_version           = lookup(var.site_config_map.value, "min_tls_version ")
    php_version               = lookup(var.site_config_map.value, "php_version")
    python_version            = lookup(var.site_config_map.value, "python_version")
    remote_debugging_version  = lookup(var.site_config_map.value, "remote_debugging_version")
    scm_type                  = lookup(var.site_config_map.value, "scm_type")
    use_32_bit_worker_process = lookup(var.site_config_map.value, "use_32_bit_worker_process")
    websockets_enabled        = lookup(var.site_config_map.value, "websockets_enabled")

    dynamic "ip_restriction" {
      for_each = local.ip_restriction_map

      content {
        ip_address                = lookup(ip_restriction.value, "ip_address")
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id")
      }
    }

    cors {
      allowed_origins     = lookup(local.site_config_cors_map.value, "allowed_origins", "*")
      support_credentials = lookup(local.site_config_cors_map.value, "support_credentials")
    }
  }

  identity {
    type         = lookup(local.identity_map.value, "type")
    identity_ids = lookup(local.identity_map.value, "identity_ids", [])
  }
}