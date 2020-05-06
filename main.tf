provider "azurerm" {
  features {}
}

resource "azurerm_template_deployment" "template_deployment" {
  name                = "sqlmitestbl1"
  resource_group_name = var.resource_group_name
  deployment_mode     = var.deployment_mode == null ? "Incremental" : var.deployment_mode
  parameters          = var.parameters
  template_body = <<DEPLOY
  {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "name": {
            "type": "string",
            "metadata": {
                "description": "Name of SQL MI."
            }
        },
        "skuName": {
            "type": "string",
            "metadata": {
                "description": "The name of the SKU, typically, a letter + Number code, e.g. P3."
            }
        },
        "skuTier": {
            "type": "string",
            "metadata": {
                "description": "The tier or edition of the particular SKU, e.g. Basic, Premium."
            }
        },
        "skuSize": {
            "type": "string",
            "metadata": {
                "description": "Size of the particular SKU"
            }
        },
        "location": {
            "type": "string",
            "metadata": {
                "description": "Location of resource"
            }
        },
        "managedInstanceCreateMode": {
            "type": "string",
            "metadata": {
                "description": "Specifies the mode of database creation."
            }
        },
        "administratorLogin": {
            "type": "string",
            "metadata": {
                "description": "Administrator username for the managed instance. Can only be specified when the managed instance is being created (and is required for creation)."
            }
        },
        "administratorLoginPassword": {
            "type": "string",
            "metadata": {
                "description": "The administrator login password (required for managed instance creation)."
            }
        },
        "subnetId": {
            "type": "string",
            "metadata": {
                "description": "Subnet resource ID for the managed instance."
            }
        },
        "licenseType": {
            "type": "string",
            "metadata": {
                "description": "Type of license: BasePrice (BYOL) or LicenceIncluded."
            },
            "allowedValues": [
                "BasePrice",
                "LicenseIncluded"
            ]
        },
        "vCores": {
            "type": "integer",
            "metadata": {
                "description": "The number of vCores. Allowed values: 8, 16, 24, 32, 40, 64, 80."
            },
            "allowedValues": [
                8,16, 24, 32, 40, 64, 80
            ]
        },
        "storageSizeInGB": {
            "type": "integer",
            "metadata": {
                "description": "Storage size in GB. Minimum value: 32. Maximum value: 8192. Increments of 32 GB allowed only."
            }
        },
        "collation": {
            "type": "integer",
            "metadata": {
                "description": "Collation of the managed instance."
            }
        },
        "collation": {
            "type": "string",
            "metadata": {
                "description": "Collation of the managed instance."
            }
        },
        "dnsZonePartner": {
            "type": "string",
            "metadata": {
                "description": "The resource id of another managed instance whose DNS zone this managed instance will share after creation."
            }
        },
        "publicDataEndpointEnabled": {
            "type": "boolean",
            "metadata": {
                "description": "Whether or not the public data endpoint is enabled."
            }
        },
        "sourceManagedInstanceId": {
            "type": "string",
            "metadata": {
                "description": "The resource identifier of the source managed instance associated with create operation of this instance."
            }
        },
        "restorePointInTime": {
            "type": "string",
            "metadata": {
                "description": "Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database."
            }
        },
        "proxyOverride": {
            "type": "string",
            "metadata": {
                "description": "Connection type used for connecting to the instance. - Proxy, Redirect, Default."
            }
        },
        "timezoneId": {
            "type": "string",
            "metadata": {
                "description": "Id of the timezone. Allowed values are timezones supported by Windows."
            }
        },
        "instancePoolId": {
            "type": "string",
            "metadata": {
                "description": "The Id of the instance pool this managed server belongs to."
            }
        },
        "minimalTlsVersion": {
            "type": "string",
            "metadata": {
                "description": "Minimal TLS version. Allowed values: 'None', '1.0', '1.1', '1.2'"
            }
        }
    },
    "variables": {
    },
    "resources": [
        {
            "type": "Microsoft.Sql/managedInstances",
            "apiVersion": "2018-06-01-preview",
            "name": "[parameters('Name')]",
            "location": "[parameters('location')]",
            "sku": {
                "name": "[parameters('skuName')]",
                "tier": "[parameters('skuTier')]",
                "size": "[parameters('skuSize')]"
            },
            "identity": {
                "type": "SystemAssigned"
            },
            "tags": "[parameters('tags')]",
            "properties": {
                "managedInstanceCreateMode": "[parameters('managedInstanceCreateMode')]",
                "administratorLogin": "[parameters('administratorLogin')]",
                "administratorLoginPassword": "[parameters('administratorLoginPassword')]",
                "subnetId": "[parameters('subnetId')]",
                "licenseType": "[parameters('licenseType')]",
                "vCores": "[parameters('vCores')]",
                "storageSizeInGB": "[parameters('')]",
                "collation": "[parameters('storageSizeInGB')]",
                "dnsZonePartner": "[parameters('dnsZonePartner')]",
                "publicDataEndpointEnabled": "[parameters('publicDataEndpointEnabled')]",
                "sourceManagedInstanceId": "[parameters('sourceManagedInstanceId')]",
                "restorePointInTime": "[parameters('restorePointInTime')]",
                "proxyOverride": "[parameters('proxyOverride')]",
                "timezoneId": "[parameters('timezoneId')]",
                "instancePoolId": "[parameters('instancePoolId')]",
                "minimalTlsVersion": "[parameters('minimalTlsVersion')]"
            }
        }
    ],
    "outputs": {
        "id": {
          "value": "[resourceId(Microsoft.Sql/managedInstances', parameters('name'))]",
          "type": "string"
        }
    }
  }
  DEPLOY
}
