terraform {
  required_providers {
    hetznerdns = {
      source = "citrix/citrixadc"
      version = "1.37.0"
    },
    powerdns = {
      source = "pan-net/powerdns"
      version = "1.5.0"
    }
  }
}