
## Create instance - will use defaults for parameters not specified (e.g. VPC, security group)
resource "aws_instance" "server" {
  count         = var.num_instances
  ami           = data.aws_ami.amazon_linux2_kernel_5.id
  instance_type = var.instance_type
  ## Note use of module (aka remainder) operator 
  ## Example if var.num_azs is 3: 
  # Instance 0 -> AZ 0
  # Instance 1 -> AZ 1
  # Instance 2 -> AZ 2
  # Instance 3 -> AZ 0
  # Instance 4 -> AZ 1
  # etc.
  subnet_id = data.aws_subnets.def_vpc_subnets.ids[count.index % var.num_azs]

  tags = {
    Name = "vm-${local.name_suffix}-${count.index}"
  }

  ## NOTE : HashiCorp discourages the use of provisioners!
  ## https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax#provisioners-are-a-last-resort
  provisioner "local-exec" {
    when = create
    command = "mkdir -p ${path.root}/temp"
  }
  provisioner "local-exec" {
    when = create
    command = "echo Server ${count.index}: IP address is ${self.private_ip} >> ${path.root}/temp/tempfile.txt"
  }
  provisioner "local-exec" {
    when = destroy
    command = "rm -rf ${path.root}/temp"
  }
}


