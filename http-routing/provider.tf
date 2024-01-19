provider "citrixadc" {
  endpoint = "${var.citrixadc_url}"
  username = "${var.citrixadc_user}"
  password = "${var.citrixadc_pass}"

  # Do not error due to non signed ADC TLS certificate
  # Can skip this if ADC TLS certificate is trusted
  insecure_skip_verify = true
}

provider "powerdns" {
  api_key    = "${var.pdns_api_key}"
  server_url = "${var.pdns_server_url}"
}