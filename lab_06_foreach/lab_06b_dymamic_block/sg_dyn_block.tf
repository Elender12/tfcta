variable "sg_ingress_ports" {
  type        = list(number)
  description = "Ingress ports for security group"
  default     = [8200, 9200, 4300]
}


resource "aws_security_group" "sg1" {
  name        = "dynamic-sg-${local.name_suffix}"
  description = "Test of dynamic blocks"
  vpc_id = data.aws_vpc.def_vpc.id
  dynamic "ingress" {
    for_each = var.sg_ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  lifecycle {
    create_before_destroy = true
  }

  tags =  {
    Name = "dynamic-sg-${local.name_suffix}-1"
  }
}

variable "sg_ingress_ports2" {
  type        = list(object(
    {
      port = string
      cidr_source = string
      protocol = string
    }
  ))

  description = "Ingress protocol, ports and CIDRs for security group"
  default = [ 
    {
      port = 80
      cidr_source = "0.0.0.0/0"
      protocol = "tcp"
    },
    {
      port = 8080
      cidr_source = "10.0.0.0/8"
      protocol = "tcp"
    },
      {
      port = 53
      cidr_source = "34.2.2.0/24"
      protocol = "udp"
    }
  ]
}

locals {
  val2 = var.sg_ingress_ports2
}

resource "aws_security_group" "sg2" {
  name        = "dynamic-sg-${local.name_suffix}-2"
  description = "Test of dynamic blocks"
  vpc_id = data.aws_vpc.def_vpc.id
  dynamic "ingress" {
    for_each = var.sg_ingress_ports2
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = [ingress.value["cidr_source"]]
    }
  }
  lifecycle {
    create_before_destroy = true
  }

  tags =  {
    Name = "dynamic-sg-${local.name_suffix}-2"
  }


}


