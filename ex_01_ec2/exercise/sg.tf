resource "aws_security_group" "plain_security_group" {
  vpc_id      = data.aws_vpc.def_vpc.id
  name        = "My first plain secutiry group"
  description = "First test of a security group"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "My first SG"
  }
}


resource "aws_vpc_security_group_egress_rule" "my_egress_rule" {
  security_group_id = aws_security_group.plain_security_group.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "my_ingress_rule" {
  security_group_id = aws_security_group.plain_security_group.id
  cidr_ipv4         = "10.0.0.0/8"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 8080

}


/*

should be separated resources????

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }*/