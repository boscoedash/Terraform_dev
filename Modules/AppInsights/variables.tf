variable "description" {
  type        = string
  description = "The description of the resource for naming."
}

variable "counter" {
  type    = number
  default = 1
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the App Service"
}

variable "tags" {
  type        = map
  description = "A key-value pair of tags."
}

variable "application_type" {
  type        = string
  description = "pecifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created."
}

variable "daily_data_cap_in_gb" {
  type        = number
  description = "Specifies the Application Insights component daily data volume cap in GB."
}

variable "daily_data_cap_notifications_disabled" {
  type        = bool
  description = "Specifies if a notification email will be send when the daily data volume cap is met."
}

variable "retention_in_days" {
  type        = number
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730."
}

variable "sampling_percentage" {
  type        = number
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry."
}

variable "disable_ip_masking" {
  type        = bool
  description = "By default the real client ip is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client ip. Defaults to false."
}
