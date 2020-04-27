locals {
  authentication_certificate_map  = var.authentication_certificate_map == null ? {} : var.authentication_certificate_map
  trusted_root_certificate_map    = var.trusted_root_certificate_map == null ? {} : var.trusted_root_certificate_map
  probe_map                       = var.probe_map == null ? {} : var.probe_map
  ssl_certificate_map             = var.ssl_certificate_map == null ? {} : var.ssl_certificate_map
  url_path_map_map                = var.url_path_map_map == null ? {} : var.url_path_map_map
  custom_error_configuration_map  = var.custom_error_configuration_map == null ? {} : var.custom_error_configuration_map
  redirect_configuration_name_map = var.redirect_configuration_name_map == null ? {} : var.redirect_configuration_name_map
  rewrite_rule_set_map            = var.rewrite_rule_set_map == null ? {} : var.rewrite_rule_set_map
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = var.application_gateway_name
  resource_group_name = var.resource_group_name
  location            = local.location
  tags                = local.tags

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  autoscale_configuration {
    min_capacity = var.autoscale_min_capacity
    max_capacity = var.autoscale_max_capacity
  }

  zones        = var.zones
  enable_http2 = var.enable_http2

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pool_map

    content {
      name         = backend_address_pool.key
      fqdns        = lookup(backend_address_pool.value, "fqdns", null)
      ip_addresses = lookup(backend_address_pool.value, "ip_addresses")
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings_map

    content {
      name                                = backend_http_settings.key
      path                                = lookup(backend_http_settings.value, "path", null)
      port                                = lookup(backend_http_settings.value, "port")
      protocol                            = lookup(backend_http_settings.value, "protocol")
      probe_name                          = lookup(backend_http_settings.value, "probe_name", null)
      request_timeout                     = lookup(backend_http_settings.value, "request_timeout", 10)
      host_name                           = lookup(backend_http_settings.value, "host_name", null)
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", false)
      trusted_root_certificate_names      = lookup(backend_http_settings.value, "trusted_root_certificate_names", null)
      cookie_based_affinity               = lookup(backend_http_settings.value, "cookie_based_affinity", "Disabled")
      affinity_cookie_name                = lookup(backend_http_settings.value, "affinity_cookie_name", null)

      connection_draining {
        enabled           = lookup(backend_http_settings.value, "conn_drain_enabled", false)
        drain_timeout_sec = lookup(backend_http_settings.value, "conn_drain_timeout_sec", 60)
      }
      

      # authentication_certificate {
      #   name = lookup(backend_http_settings.value, "auth_cert_name", null)
      # }
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_config_map

    content {
      name                          = frontend_ip_configuration.key
      subnet_id                     = lookup(frontend_ip_configuration.value, "subnet_id")
      private_ip_address            = lookup(frontend_ip_configuration.value, "private_ip_address")
      public_ip_address_id          = lookup(frontend_ip_configuration.value, "public_ip_address_id")
      private_ip_address_allocation = lookup(frontend_ip_configuration.value, "private_ip_address_allocation")
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_port_map

    content {
      name = frontend_port.key
      port = lookup(frontend_port.value, "port")
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = var.gateway_ip_config_map

    content {
      name      = gateway_ip_configuration.key
      subnet_id = lookup(gateway_ip_configuration.value, "subnet_id")
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listener_map

    content {
      name                           = http_listener.key
      frontend_ip_configuration_name = lookup(http_listener.value, "frontend_ip_configuration_name")
      frontend_port_name             = lookup(http_listener.value, "frontend_port_name")
      host_name                      = lookup(http_listener.value, "host_name", null)
      protocol                       = lookup(http_listener.value, "protocol", "http")
      require_sni                    = lookup(http_listener.value, "require_sni", null)
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)

      dynamic "custom_error_configuration" {
        for_each = http_listener.value.custom_error_configuration == "" ? {} : http_listener.value.custom_error_configuration


        content {
          status_code           = lookup(custom_error_configuration.value, "status_code", null)
          custom_error_page_url = lookup(custom_error_configuration.value, "custom_error_page_url", null)
        }
      }
    }
  }


  identity {
    identity_ids = var.identity_ids
    type         = var.identity_type
  }


  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule_map

    content {
      name                        = request_routing_rule.key
      rule_type                   = lookup(request_routing_rule.value, "rule_type")
      http_listener_name          = lookup(request_routing_rule.value, "http_listener_name")
      backend_address_pool_name   = lookup(request_routing_rule.value, "backend_address_pool_name", null)
      backend_http_settings_name  = lookup(request_routing_rule.value, "backend_http_settings_name", null)
      redirect_configuration_name = lookup(request_routing_rule.value, "redirect_configuration_name", null)
      rewrite_rule_set_name       = lookup(request_routing_rule.value, "rewrite_rule_set_name", null)
      url_path_map_name           = lookup(request_routing_rule.value, "url_path_map_name", null)
    }
  }

  dynamic "authentication_certificate" {
    for_each = local.authentication_certificate_map

    content {
      name = authentication_certificate.key
      data = lookup(authentication_certificate.value, "data")
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = local.trusted_root_certificate_map

    content {
      name = trusted_root_certificate.key
      data = lookup(trusted_root_certificate.value, "data")
    }
  }

  ssl_policy {
    policy_type          = var.ssl_policy_type
    cipher_suites        = var.ssl_cipher_suites_max_v2
    min_protocol_version = var.ssl_min_protocol_version
  }

  dynamic "probe" {
    for_each = local.probe_map

    content {
      name                                      = probe.key
      host                                      = lookup(probe.value, "host")
      interval                                  = lookup(probe.value, "interval", 30)
      protocol                                  = lookup(probe.value, "protocol")
      path                                      = lookup(probe.value, "path")
      timeout                                   = lookup(probe.value, "timeout", 30)
      unhealthy_threshold                       = lookup(probe.value, "unhealthy_threshold", 3)
      pick_host_name_from_backend_http_settings = lookup(probe.value, "pick_host_name_from_backend_http_settings", false)
      minimum_servers                           = lookup(probe.value, "minimum_servers", 0)

      dynamic "match" {
        for_each = probe.value.match == "" ? {} : probe.value.match

        content {
          body        = lookup(match.value, "body")
          status_code = lookup(match.value, "status_code")
        }
      }

    }
  }

  dynamic "ssl_certificate" {
    for_each = local.ssl_certificate_map

    content {
      name                = ssl_certificate.key
      key_vault_secret_id = lookup(ssl_certificate.value, "key_vault_secret_id")
      #data                = lookup(ssl_certificate.value, "data")
      #password            = lookup(ssl_certificate.value, "password")
    }
  }

  dynamic "url_path_map" {
    for_each = local.url_path_map_map

    content {
      name                                = url_path_map.key
      default_backend_address_pool_name   = lookup(url_path_map.value, "default_backend_address_pool_name")
      default_backend_http_settings_name  = lookup(url_path_map.value, "default_backend_http_settings_name")
      default_redirect_configuration_name = lookup(url_path_map.value, "default_redirect_configuration_name")
      default_rewrite_rule_set_name       = lookup(url_path_map.value, "default_rewrite_rule_set_name")

      dynamic "path_rule" {
        for_each = url_path_map.value.path_rule
        content {
          name                        = path_rule.key
          paths                       = lookup(path_rule.value, "paths")
          backend_address_pool_name   = lookup(path_rule.value, "backend_address_pool_name")
          backend_http_settings_name  = lookup(path_rule.value, "backend_http_settings_name")
          redirect_configuration_name = lookup(path_rule.value, "redirect_configuration_name")
          rewrite_rule_set_name       = lookup(path_rule.value, "rewrite_rule_set_name")
        }
      }
    }
  }

  dynamic "custom_error_configuration" {
    for_each = local.custom_error_configuration_map

    content {
      status_code           = lookup(custom_error_configuration.value, "status_code")
      custom_error_page_url = lookup(custom_error_configuration.value, "custom_error_page_url")
    }
  }

  dynamic "redirect_configuration" {
    for_each = local.redirect_configuration_name_map

    content {
      name                 = redirect_configuration.key
      redirect_type        = lookup(redirect_configuration.value, "redirect_type")
      target_listener_name = lookup(redirect_configuration.value, "target_listener_name")
      target_url           = lookup(redirect_configuration.value, "target_url")
      include_path         = lookup(redirect_configuration.value, "include_path")
      include_query_string = lookup(redirect_configuration.value, "include_query_string")
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = local.rewrite_rule_set_map

    content {
      name = rewrite_rule_set.key

      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.rewrite_rule == "" ? {} : rewrite_rule_set.value.rewrite_rule

        content {
          name          = rewrite_rule.key
          rule_sequence = lookup(rewrite_rule.value, "rule_sequence")

          dynamic "condition" {
            for_each = rewrite_rule.value.condition == "" ? {} : rewrite_rule.value.condition

            # for_each = rewrite_rule.value.condition
            content {
              variable    = lookup(condition.value, "variable")
              pattern     = lookup(condition.value, "pattern")
              ignore_case = lookup(condition.value, "ignore_case")
              negate      = lookup(condition.value, "negate")
            }
          }

          dynamic "request_header_configuration" {
            for_each = rewrite_rule.value.request_header_configuration == "" ? {} : rewrite_rule.value.request_header_configuration

            content {
              header_name  = lookup(request_header_configuration.value, "header_name")
              header_value = lookup(request_header_configuration.value, "header_value")
            }
          }

          dynamic "response_header_configuration" {
            for_each = rewrite_rule.value.response_header_configuration == "" ? {} : rewrite_rule.value.response_header_configuration

            content {
              header_name  = lookup(response_header_configuration.value, "header_name")
              header_value = lookup(response_header_configuration.value, "header_value")
            }
          }
        }
      }
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "log-analytics" {
  name                       = "log-analytics"
  target_resource_id         = azurerm_application_gateway.app_gateway.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "ApplicationGatewayAccessLog"
    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  log {
    category = "ApplicationGatewayPerformanceLog"
    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  log {
    category = "ApplicationGatewayFirewallLog"
    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }
  
  metric {
    category = "AllMetrics"
    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }
}
