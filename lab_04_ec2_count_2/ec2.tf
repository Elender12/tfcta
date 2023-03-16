data "aws_ami" "amazon_linux2_kernel_5" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0*x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}



## Create instance - will use defaults for parameters not specified (e.g. VPC, security group)
resource "aws_instance" "server" {
  count = local.ninstances
  # ami           = var.my_ami
  ami           = data.aws_ami.amazon_linux2_kernel_5.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.sec_web.id]

  tags = {
    Name = "server-${local.name_suffix}-${var.instance_names[count.index]}"
  }
}



