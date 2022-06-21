provider "azurerm" {
  features {}
}

module "tfdemo_resourcegroup" {
  source              = "./Modules/ResourceGroup"
  resource_group_name = "rg-${var.deployment_prefix}"
  location            = var.location
  resource_group_tags = var.resource_group_tags
}

module "tfdemo_vnet" {
  source                        = "./Modules/VirtualNetwork"
  virtual_network_name          = "vnt-${var.deployment_prefix}"
  virtual_network_address_space = var.virtual_network_address_space
  location                      = var.location
  resource_group_name           = module.tfdemo_resourcegroup.resource_group_name
}

module "tfdemo_subnet" {
  source               = "./Modules/Subnet"
  subnet_name          = "default"
  resource_group_name  = module.tfdemo_resourcegroup.resource_group_name
  virtual_network_name = module.tfdemo_vnet.virtual_network_name
  subnet_address_space = var.subnet_address_space
}

module "tfdemo_nic" {
  source               = "./Modules/NetworkInterface"
  nic_name             = "nic-${var.deployment_prefix}"
  location             = var.location
  resource_group_name  = module.tfdemo_resourcegroup.resource_group_name
  ip_configuration_map = {
    name                          = "internal"
    subnet_id                     = module.tfdemo_subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

module "tfdemo_virtual_machine" {
  source                = "./Modules/WindowsVirtualMachine"
  vm_name               = "${var.deployment_prefix}-vm"
  location              = var.location
  resource_group_name   = module.tfdemo_resourcegroup.resource_group_name
  network_interface_ids = [module.tfdemo_nic.id]
  vm_size               = var.vm_size
  storage_os_disk_map   = var.storage_os_disk
  os_profile_map        = var.os_profile
  vm_tags               = var.vm_tags
}
