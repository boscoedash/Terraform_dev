terraform {
  required_version = ">= 0.12"
}

locals {
  storage_os_disk_map = var.storage_os_disk_map == null ? {} : var.storage_os_disk_map
  os_profile_map = var.os_profile_map == null ? {} : var.os_profile_map
}

resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.network_interface_ids
  vm_size               = var.vm_size
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = lookup(local.storage_os_disk_map, "name")
    caching           = lookup(local.storage_os_disk_map, "caching")
    create_option     = lookup(local.storage_os_disk_map, "create_option")
    managed_disk_type = lookup(local.storage_os_disk_map, "managed_disk_type")
  }
  os_profile {
    computer_name  = lookup(local.os_profile_map, "computer_name")
    admin_username = lookup(local.os_profile_map, "admin_username")
    admin_password = lookup(local.os_profile_map, "admin_password")
  }
  os_profile_windows_config {
    enable_automatic_upgrades = true
    winrm {
      protocol = "http"
    }
  }
  tags = var.vm_tags
}
