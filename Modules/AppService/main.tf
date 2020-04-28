provider "azurerm" {
  features {}
}

module "naming" {
  source      = "../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "as"
}

locals {

  logs_map                        = var.logs_map == null ? {} : var.logs_map
  site_config_cors_map            = var.site_config_cors_map == null ? {} : var.site_config_cors_map
  identity_map                    = var.identity_map  == null ? {} : var.identity_map
  app_settings_map                = var.app_settings_map  == null ? {} : var.app_settings_map
  auth_settings_map               = var.auth_settings_map  == null ? {} : var.auth_settings_map
  active_directory_map            = var.active_directory_map  == null ? {} : var.active_directory_map
  storage_account_map             = var.storage_account_map  == null ? {} : var.storage_account_map
  backup_map                      = var.backup_map  == null ? {} : var.backup_map
  schedule_map                    = var.schedule_map  == null ? {} : var.schedule_map
  ip_restriction_map              = var.ip_restriction_map == null ? {} : var.ip_restriction_map
}

resource "azurerm_app_service" "app_service" {
  name                    = lower(module.naming.name)
  location                = local.location
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = var.app_service_plan_id
  app_settings_map        = local.app_settings_map
  client_affinity_enabled = var.client_affinity_enabled
  client_cert_enabled     = var.client_cert_enabled
  enabled                 = var.enabled
  https_only              = var.https_only
  tags                    = local.tags

  auth_settings {
    enabled                        = local.auth_settings_map_enabled
    additional_login_params        = local.auth_settings_map_additional_login_params
    allowed_external_redirect_urls = local.auth_settings_map_allowed_external_redirect_urls
    default_provider               = local.auth_settings_map_default_provider
    runtime_version                = local.auth_settings_map_runtime_version
    token_refresh_extension_hours  = local.auth_settings_map_token_refresh_extension_hours
    token_store_enabled            = local.auth_settings_map_token_store_enabled
    unauthenticated_client_action  = local.auth_settings_map_unauthenticated_client_action
    issuer                         = local.auth_settings_map_isuer

    active_directory {
      client_id         = local.active_directory_map_client_id
      client_secret     = local.active_directory_map_client_secret
      allowed_audiences = local.active_directory_mapclient_id
    }
  }

  storage_account {
    name         = lookup(local.storage_account, "name")
    type         = lookup(local.storage_account, "type")
    account_name = lookup(local.storage_account, "account_name")
    share_name   = lookup(local.storage_account, "share_name")
    access_key   = lookup(local.storage_account, "access_key")
    mount_path   = lookup(local.storage_account, "mount_path", null)
  }

  backup {
    name                = local.backup_map_name
    enabled             = local.backup_map_enabled
    storage_account_url = local.backup_map_storage_account_url == "" ? {} : local.backup_map_storage_account_url

    schedule {
      frequency_interval       = lookup(local.schedule_map.value, "frequency_interval")
      frequency_unit           = lookup(local.schedule_map.value, "frequency_unit")
      keep_at_least_one_backup = lookup(local.schedule_map.value, "keep_at_least_one_backup")
      retention_period_in_days = lookup(local.schedule_map.value, "retention_period_in_days")
      start_time               = lookup(local.schedule_map.value, "start_time")
    }
  }

  connection_string {
    name  = var.connection_string_name
    type  = var.connection_string_type
    value = var.connection_string_value
  }

  logs {
    application_logs_map {
      azure_blob_storage {
        level             = lookup(local.logs_map.value.application_logs_map.value.azure_blob_storage.value, "level", "Off")
        sas_url           = lookup(local.logs_map.value.application_logs_map.value.azure_blob_storage.value, "sas_url")
        retention_in_days = lookup(local.logs_map.value.application_logs_map.value.azure_blob_storage.value, "retention_in_days", 30)
      }
    }

    http_logs {
      azure_blob_storage {
        level             = lookup(local.logs_map.value.application_logs_map.value.azure_blob_storage.value, "level", "Off")
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
    always_on                 = lookup(var.site_config.value, "site_config_always_on", false)
    app_command_line          = lookup(var.site_config.value, "site_config_app_command_line")
    default_documents         = lookup(var.site_config.value, "site_config_default_documents")
    dotnet_framework_version  = lookup(var.site_config.value, "site_config_dotnet_framework_version", "v4.0")
    ftps_state                = lookup(var.site_config.value, "site_config_ftps_state")
    http2_enabled             = lookup(var.site_config.value, "site_config_http2_enabled", false)
    java_version              = lookup(var.site_config.value, "site_config_java_version")
    java_container            = lookup(var.site_config.value, "site_config_java_container")
    java_container_version    = lookup(var.site_config.value, "site_config_java_container_version")
    local_mysql_enabled       = lookup(var.site_config.value, "site_config_local_mysql_enabled")
    linux_fx_verison          = lookup(var.site_config.value, "site_config_linux_fx_verison")
    windows_fx_verison        = lookup(var.site_config.value, "site_config_windows_fx_verison")
    managed_pipeline_version  = lookup(var.site_config.value, "site_config_windows_fx_verison")
    min_tls_version           = lookup(var.site_config.value, "site_config_windows_fx_verison")
    php_version               = lookup(var.site_config.value, "site_config_windows_fx_verison")
    python_verison            = lookup(var.site_config.value, "site_config_windows_fx_verison")
    remote_debugging_version  = lookup(var.site_config.value, "site_config_windows_fx_verison")
    scm_type                  = lookup(var.site_config.value, "site_config_windows_fx_verison")
    use_32_bit_worker_process = lookup(var.site_config.value, "site_config_windows_fx_verison")
    websockets_enabled        = lookup(var.site_config.value, "site_config_windows_fx_verison")

    dynamic "ip_restriction" {
      for_each = local.ip_restriction_map

      content {
        ip_address                = lookup(ip_restriction_map.value, "ip_address")
        virtual_network_subnet_id = lookup(ip_restriction_map.value, "virtual_network_subnet_id")
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