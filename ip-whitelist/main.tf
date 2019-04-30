
locals {
    wafs = [
        { type = "IPV4", value = "1.2.3.4/32"},
        { type = "IPV4", value = "5.6.7.8/32"},
    ]
}

resource "null_resource" "ipv4" {
    count = "${length(local.wafs)}"

    triggers {

        cidr = "${
        lookup(local.wafs[count.index], "type") == "IPV4"
        ? lookup(local.wafs[count.index], "value")
        : ""
        }"
    }
}

//TODO: cidr v6
output "cidr" {
    value = ["${compact(null_resource.ipv4.*.triggers.cidr)}"]
}

output "waf" {
    value = ["${local.wafs}"]
}

