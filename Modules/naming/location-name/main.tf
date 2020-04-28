locals {
  location_to_abbv = {
    "canadacentral" : {
      long : "CACN",
      short : "CC"
    },
    "canadaeast" : {
      long : "CAEA",
      short : "CE"
    }
  }
  unknown_abbv = {
    long : "UNKN",
    short : "UN"
  }
}

locals {
  location_abbv = lookup(local.location_to_abbv, lower(var.location), local.unknown_abbv)
}
