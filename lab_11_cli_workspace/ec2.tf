
# Locals for debugging

# locals {
#   da_count = lookup(var.num_instances, terraform.workspace)
#   da_type = lookup(var.instance_type, terraform.workspace)
# }

resource "aws_instance" "server" {
  count         = lookup(var.num_instances, terraform.workspace)
  instance_type = lookup(var.instance_type, terraform.workspace)
  
  ami           = data.aws_ami.amazon_linux2_kernel_5.id

  subnet_id = data.aws_subnets.def_vpc_subnets.ids[count.index % var.num_azs]

  tags = {
    Name = "vm-${local.name_suffix}-${count.index}"
  }
}


