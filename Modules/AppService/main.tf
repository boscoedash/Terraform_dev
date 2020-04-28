module "naming" {
  source      = "../../../naming/standard-name"
  counter     = var.counter
  description = var.description
  location    = local.location
  type        = "as"
}

locals {

  logs                        = var.logs == null ? {} : var.logs
  storage_account_mount_path  = var.storage_account_mount_path == null ? {} : var.storage_account_mount_path
  site_config_cors            = var.site_config_cors == null ? {} : var.site_config_cors
  identity                    = var.identity  == null ? {} : var.identity
  app_settings                = var.app_settings  == null ? {} : var.app_settings
  auth_settings               = var.auth_settings  == null ? {} : var.auth_settings
  active_directory            = var.active_directory  == null ? {} : var.active_directory
  backup                      = var.backup  == null ? {} : var.backup
  ip_restriction              = var.ip_restriction == null ? {} : var.ip_restriction
}

resource "azurerm_app_service" "app_service" {
  name                    = lower(module.naming.name)
  location                = local.location
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = var.app_service_plan_id
  app_settings            = local.app_settings
  client_affinity_enabled = var.client_affinity_enabled
  client_cert_enabled     = var.client_cert_enabled
  enabled                 = var.enabled
  https_only              = var.https_only
  tags                    = local.tags

  auth_settings {
    enabled                        = local.auth_settings_enabled
    additional_login_params        = local.auth_settings_additional_login_params
    allowed_external_redirect_urls = local.auth_settings_allowed_external_redirect_urls
    default_provider               = local.auth_settings_default_provider
    runtime_version                = local.auth_settings_runtime_version
    token_refresh_extension_hours  = local.auth_settings_token_refresh_extension_hours
    token_store_enabled            = local.auth_settings_token_store_enabled
    unauthenticated_client_action  = local.auth_settings_unauthenticated_client_action
    issuer                         = local.auth_settings_isuer

    active_directory {
      client_id         = local.active_directory.value.client_id
      client_secret     = local.active_directory.value.client_secret
      allowed_audiences = local.active_directory.value.client_id
    }
  }

  storage_account {
    name         = var.storage_account_identifier
    type         = var.storage_account_type
    account_name = var.storage_account_name
    share_name   = var.storage_account_share_name
    access_key   = var.storage_account_access_key
    mount_path   = local.storage_account_mount_path 
  }

  backup {
    name                = local.backup_name
    enabled             = local.backup_enabled
    storage_account_url = local.backup_storage_account_url == "" ? {} : local.backup_storage_account_url

    dynamic "schedule" {
      for_each backup.value.schedule == "" ? {} : backup.value.schedule
      
      content {
        frequency_interval       = lookup(schedule.value, "frequency_interval")
        frequency_unit           = lookup(schedule.value, "frequency_unit")
        keep_at_least_one_backup = lookup(schedule.value, "keep_at_least_one_backup")
        retention_period_in_days = lookup(schedule.value, "retention_period_in_days")
        start_time               = lookup(schedule.value, "start_time")
      }
    }
  }

  connection_string {
    name  = var.connection_string_name
    type  = var.connection_string_type
    value = var.connection_string_value
  }

  dynamic "logs" {
    for_each = local.logs
    
    content {
      dynamic "application_logs" {
        for_each = logs.value.application_logs == "" ? {} : logs.value.application_logs

        content {
          dynamic "azure_blob_storage" {
            for_each = logs.value.application_logs.value.azure_blob_storage == "" ? {} : logs.value.application_logs.value.azure_blob_storage

            content {
              level             = lookup(azure_blob_storage.value, "level", "Off")
              sas_url           = lookup(azure_blob_storage.value, "sas_url")
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days", 30)
            }
          }
        }
      }

      dynamic "http_logs" {
        for_each = logs.value.http_logs == "" ? {} : logs.value.http_logs

        content {
          dynamic "azure_blob_storage" {
            for_each = logs.value.http_logs.value.azure_blob_storage == "" ? {} : logs.value.http_logs.value.azure_blob_storage

            content {
              level             = lookup(azure_blob_storage.value, "level", "Off")
              sas_url           = lookup(azure_blob_storage.value, "sas_url")
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days", 30)
            }
          }

          dynamic "file_system" {
            for_each = logs.value.http_logs.value.file_system == "" ? {} : logs.value.http_logs.value.file_system

            content {
              retention_in_mb   = lookup(file_system.value, "retention_in_mb")
              retention_in_days = lookup(file_system.value, "retention_in_days", 30)
            }
          }
        }
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
      for_each = local.ip_restriction

      content {
        ip_address                = lookup(ip_restriction.value, "ip_address")
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id")
      }
    }

    dynamic "cors" {
      for_each = local.site_config_cors

      content {
        allowed_origins     = lookup(site_config_cors.value, "allowed_origins", "*")
        support_credentials = lookup(site_config_cors.value, "support_credentials")
      }
    }
  }

  identity {
    type         = lookup(local.identity.value, "type")
    identity_ids = lookup(local.identity.value, "identity_ids", [])
  }
}