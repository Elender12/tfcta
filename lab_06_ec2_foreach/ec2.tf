
## Start with this configurattion
## Note the object is defined explicitly inside the resource

# resource "aws_instance" "server1" {
#   ami                    = data.aws_ami.amazon_linux2_kernel_5.id
#   vpc_security_group_ids = [aws_security_group.sec_web.id]

#   for_each = {
#     dep1 = "t2.micro"
#     dep2 = "t3.micro"
#     dep3 = "t3.micro"
#     dep4 = "t2.micro"
#   }
#   instance_type = each.value
#   tags = {
#     Name = "server-${local.name_suffix}-${each.value}"  
#   }
# }


## Here we create an object variable with the same content we used explicitly above
## Note last item using spaces
locals {
  instance_info = {
    dep1 = "t2.micro"
    dep2 = "t3.micro"
    dep3 = "t3.micro"
    "department 4" = "t2.micro"
  }
}

locals {
  test1 = { for key, val in local.instance_info : upper(key) => upper(val)}
  test2 = [for clave, valor in local.instance_info : "Maps ${clave} to ${valor}"]
  test3 = [for k, instance in aws_instance.server2 : instance.public_ip]
  test4 = { for k, instance in aws_instance.server2 : instance.public_dns => instance.public_ip }

  test5 = { for k, instance in aws_instance.server2 : instance.id => { (instance.public_dns) = instance.public_ip }}
  test6 = [for k, instance in aws_instance.server2 : instance.public_dns]
  test7 = zipmap(local.test3, local.test6)
}




## And then we use it in the "for_each" 
resource "aws_instance" "server2" {
  ami                    = data.aws_ami.amazon_linux2_kernel_5.id
  vpc_security_group_ids = [aws_security_group.sec_web.id]

  for_each = local.instance_info
  instance_type = each.value
  tags = {
    Name = "server-${each.key}-${each.value}"  
  }
}




