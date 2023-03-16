

## Security group the recommended way - each rule is a separate resource referencing the SG resource

resource "aws_security_group" "sec" {
  vpc_id = data.aws_vpc.def_vpc.id
  name   = "sec-rec-${local.name_suffix}"

    lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "example" {
  security_group_id = aws_security_group.sec.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 0
}

resource "aws_vpc_security_group_ingress_rule" "rule_icmp" {
  security_group_id = aws_security_group.sec.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 8
  ip_protocol = "icmp"
  to_port     = 0
}


resource "aws_vpc_security_group_ingress_rule" "rule_http" {
  security_group_id = aws_security_group.sec.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "rule_https" {
  security_group_id = aws_security_group.sec.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "rule_special" {
  security_group_id = aws_security_group.sec.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = var.special_port
  ip_protocol = "tcp"
  to_port     = var.special_port
}

resource "aws_vpc_security_group_ingress_rule" "rule_ssh" {
  security_group_id = aws_security_group.sec.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}



## Security group the non-recommended way - all rules inside a single resource
resource "aws_security_group" "sec_web1" {
  vpc_id = data.aws_vpc.def_vpc.id
  name   = "sec-web-${local.name_suffix}"
  ingress {
    description = "SSH from specific addresses"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.sec_allowed_external
  }
  ingress {
    description = "Ping from specific addresses"
    from_port   = 8 # ICMP Code 8 - echo  (0 is echo reply)
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = var.sec_allowed_external
  }

  ingress {
    description = "TCP Port 80 from specific addresses"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.sec_allowed_external
  }

  ingress {
    description = "Allow TCP for special port from specific addresses"
    from_port   = var.special_port
    to_port     = var.special_port
    protocol    = "tcp"
    cidr_blocks = var.sec_allowed_external
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sec-web"
  }
  lifecycle {
    create_before_destroy = true
  }
}



