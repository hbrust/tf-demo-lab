# create A record for target
resource "powerdns_record" "${var.http_route.name}_dns" {
  zone    = "demo.lab."
  name    = "${var.http_route.hostname}."
  type    = "A"
  ttl     = 300
  records = ["${var.http_route.cs_vip}"]
}

# ADC tasks

resource "citrixadc_lbvserver" "${var.http_route.name}_lbvserver" {
  name = "vs_${var.http_route.name}"
  port = 80
  servicetype = "HTTP"
}

resource "citrixadc_service" "${var.http_route.name}_service" {
  name = "${var.http_route.target_host}_service"
  ip = "${var.http_route.target_host}"
  servicetype  = "HTTP"
  port = var.http_route.target_port
}

resource "citrixadc_lbvserver_service_binding" "${var.http_route.name}_binding" {
  name = citrixadc_lbvserver.${var.http_route.name}_lbvserver.name
  servicename = citrixadc_service.${var.http_route.name}_service.name
  weight = 1
  order = 10
}

resource "citrixadc_csaction" "${var.http_route.name}_csact" {
  name            = "csact_${var.http_route.name}"
  targetlbvserver = citrixadc_lbvserver.${var.http_route.name}_lbvserver.name
  comment         = "${var.http_route.name} / ${var.http_route.target_host}"
}

resource "citrixadc_csvserver" "${var.http_route.name}_csvserver" {
  ipv46       = "${var.http_route.cs_vip}"
  port        = 80
  servicetype = "HTTP"
}

resource "citrixadc_cspolicy" "${var.http_route.name}_cspolicy" {
  policyname = "cspolicy_${var.http_route.name}"
  rule       = "CLIENT.HTTP.REQ.HOSTNAME.TOLOWER.EQ(${var.http_route.hostname})"
}

resource "citrixadc_csvserver_cspolicy_binding" "${var.http_route.name}_csvscspolbind" {
  name                   = citrixadc_csvserver.${var.http_route.name}_csvserver.name
  policyname             = citrixadc_cspolicy.${var.http_route.name}_cspolicy.policyname
  gotopriorityexpression = "NEXT"
}

