module "ip-whitelist" {
  source = "../ip-whitelist"
}

resource "aws_security_group" "name" {
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["${module.ip-whitelist.cidr}"]
  }
}

