
## Create instance - will use defaults for parameters not specified (e.g. VPC, security group)
resource "aws_instance" "server1" {
  ami           = data.aws_ami.ubuntu_22_04_r1.id
  instance_type = var.instance_type

  subnet_id = data.aws_subnets.def_vpc_subnets_r1.ids[0]
  tags = {
    Name = "vm-${local.name_suffix}-1"
  }
}



resource "aws_instance" "server2" {
  ami           = data.aws_ami.ubuntu_22_04_r1.id
  instance_type = var.instance_type
  subnet_id = data.aws_subnets.def_vpc_subnets_r1.ids[1]

  tags = {
    Name = "vm-${local.name_suffix}-2"
  }
}

resource "aws_instance" "server3" {
  provider = aws.region2
  ami           = data.aws_ami.ubuntu_22_04_r2.id
  instance_type = var.instance_type
  subnet_id = data.aws_subnets.def_vpc_subnets_r2.ids[0]
  tags = {
    Name = "vm-${local.name_suffix}-3"
  }
}



resource "aws_instance" "server4" {
  provider = aws.region2
  ami           = data.aws_ami.ubuntu_22_04_r2.id
  instance_type = var.instance_type
  subnet_id = data.aws_subnets.def_vpc_subnets_r2.ids[1]

  tags = {
    Name = "vm-${local.name_suffix}-4"
  }
}



