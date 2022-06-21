# Global

variable "location" {
  type    = string
  default = "Central US"
}

variable "deployment_prefix" {
  type    = string
  default = "tfdemo"
}

# Resource Group

variable "resource_group_tags" {
  type    = map
  default = {
      environment = "demo"
  }
}

# Virtual Network

variable "virtual_network_address_space" {
  type    = list
  default = ["10.0.0.0/16"]
}

# Subnet 

variable "subnet_address_space" {
  type    = list
  default = ["10.0.1.0/24"]
}

# NIC

variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}

# VM

variable "vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}

variable "storage_os_disk" {
  type    = map
  default = {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}

variable "os_profile" {
  type    = map
  default = {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "1qaz2wsx!QAZ@WSX"
  }
}
variable "vm_tags" {
  type    = map
  default = {
      environment = "demo"
  }
}