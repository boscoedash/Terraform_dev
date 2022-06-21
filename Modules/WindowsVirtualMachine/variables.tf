variable "resource_group_name" {
  description = "Name of the subnet resource group."
}
variable "location" {
  description = "Location of the nic."
}
variable "vm_name" {
  description = "Name of the nic."
}
variable "network_interface_ids" {
  description = "NIC ID/s"
}
variable "vm_size" {
  description = "vm size."
}
variable "storage_os_disk_map" {
  description = "OS Disk Map."
}
variable "os_profile_map" {
  description = "OS profile Map."
}
variable "vm_tags" {
  description = "vm tags"
}
