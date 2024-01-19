# Netscaler variables
variable "citrixadc_url" {
  type = string
}

variable "citrixadc_user" {
  type = string
}

variable "citrixadc_pass" {
  type = string
}

# PowerDNS variables 
variable "pdns_api_key" {
  type = string
}

variable "pdns_server_url" {
  type = string
}

variable "http_route" {
    type = object({
        name = string
        cs_vip = string
        hostname = string
        target_host = string
        target_port = number
    })
}