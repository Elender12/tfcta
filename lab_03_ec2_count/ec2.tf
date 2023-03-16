
## Create instance - will use defaults for parameters not specified (e.g. VPC, security group)
resource "aws_instance" "server" {
  count         = var.num_instances
  ami           = var.my_ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.sec_web.id]

  tags = {
    Name = "vm-${local.name_suffix}-${count.index}"
  }
}



