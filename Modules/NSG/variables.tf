variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to create the storage account under."
}

variable "securityrules" {
  type        = list
  description = "List of Security Rule Objects."
}

variable "tags" {
  type        = map(string)
  description = "The tags to assign to the resources.  Defaults to the tags of the containing resource group."
  default     = null
}

variable "description" {
  type        = string
  description = "The description of the resource for naming."
}

variable "subnet_id" {
  type        = string
  description = "The Subnet ID to associate the NSG with."
}

variable "counter" {
  type    = number
  default = 1
}

variable "network_watcher_name" {
  type        = string
  description = "The name of the Network Watcher."
}

variable "network_watcher_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Network Watcher was deployed."
  default     = "NetworkWatcherRG"
}

variable "storage_account_id" {
  type        = string
  description = "The ID of the Storage Account where flow logs are stored."
  default     = "/subscriptions/b42e79d8-be4b-4f86-9f37-2703410b4d5d/resourceGroups/prd-crpss01-cc-rgp-globalmonitor01/providers/Microsoft.Storage/storageAccounts/pcrpss01ccstglobalmon01"
}

variable "nsg_flow_log_enabled" {
  type        = bool
  description = "Should Network Flow Logging be Enabled"
  default     = true
}

variable "nsg_flow_log_version" {
  type        = number
  description = "The version (revision) of the flow log."
  default     = 2
}

variable "nsg_flow_log_retention_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable retention."
  default     = true
}

variable "retention_policy_days" {
  type        = number
  description = "The number of days to retain flow log records."
  default     = 90
}

variable "nsg_flow_log_traffic_analysis_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable retention."
  default     = true
}

variable "workspace_id" {
  type        = string
  description = "The resource guid of the attached workspace."
  default     = "9d8b479f-1bf8-439e-807b-9265c1a876d0"
}

variable "workspace_region" {
  type        = string
  description = "The location of the attached workspace."
  default     = "canadacentral"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The resource ID of the attached workspace."
  default     = "/subscriptions/b42e79d8-be4b-4f86-9f37-2703410b4d5d/resourcegroups/prd-crpss01-cc-rgp-globalmonitor01/providers/microsoft.operationalinsights/workspaces/prd-crpss01-cc-law-globalmon01"
}

variable "interval_in_minutes" {
  type        = number
  description = "How frequently service should do flow analytics in minutes."
  default     = 10
}

variable "log_analytics_retention_days" {
  type        = number
  description = "The number of days to retain diagnostic logs."
  default     = 90
}
