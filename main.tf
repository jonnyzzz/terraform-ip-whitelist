// An example entry-point

module "ip-whitelist" {
  source = "ip-whitelist"
}


output "cidr" {
  value = "${module.ip-whitelist.cidr}"
}

output "waf" {
  value = "${module.ip-whitelist.waf}"
}

