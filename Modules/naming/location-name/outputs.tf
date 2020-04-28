output "long_abbv" {
  value       = local.location_abbv["long"]
  description = "The four-letter abbreviation for the location."
}

output "short_abbv" {
  value       = local.location_abbv["short"]
  description = "The two-letter abbreviation for the location."
}
