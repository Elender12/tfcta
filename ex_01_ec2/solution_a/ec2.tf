
## Create instance - will use defaults for parameters not specified (e.g. VPC, security group)
resource "aws_instance" "server1" {
  ami           = data.aws_ami.ubuntu_22_04.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.sec.id]
  subnet_id = data.aws_subnets.def_vpc_subnets.ids[0]
  tags = {
    Name = "vm-${local.name_suffix}-1"
  }
}



resource "aws_instance" "server2" {
  ami           = data.aws_ami.ubuntu_22_04.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.sec.id]
  subnet_id = data.aws_subnets.def_vpc_subnets.ids[1]

  tags = {
    Name = "vm-${local.name_suffix}-2"
  }
}
