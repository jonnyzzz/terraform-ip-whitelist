
locals {
  cf_name ="TODO-name"
  cf_waf_rule = "TODO-rule"
  cf_waf_acl = "TODO-acl"
}

module "ip_whitelist" {
    source = "../ip-whitelist"
}

resource "aws_waf_ipset" "ipset" {
    name = "${local.cf_name}-waf"
    ip_set_descriptors = ["${module.ip_whitelist.waf}"]
}

resource "aws_waf_rule" "wafrule" {
    depends_on  = ["aws_waf_ipset.ipset"]

    name        = "${local.cf_waf_rule}"
    metric_name = "${local.cf_waf_rule}"

    predicates {
        data_id = "${aws_waf_ipset.ipset.id}"
        negated = false
        type    = "IPMatch"
    }
}

resource "aws_waf_web_acl" "waf_acl" {
    depends_on  = ["aws_waf_ipset.ipset", "aws_waf_rule.wafrule"]

    name        = "${local.cf_waf_acl}"
    metric_name = "${local.cf_waf_acl}"

    default_action {
        type = "BLOCK"
    }

    rules {
        action {
            type = "ALLOW"
        }

        priority = 1
        rule_id  = "${aws_waf_rule.wafrule.id}"
        type     = "REGULAR"
    }
}

