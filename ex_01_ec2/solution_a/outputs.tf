output "public_ip1" {
  description = "Public IP of instance"
  value       = aws_instance.server1.public_ip
}

output "public_ip2" {
  description = "Public IP of instance"
  value       = aws_instance.server2.public_ip
}

output "ami1" {
  description = "AMI of instance"
  value       = aws_instance.server1.ami
}
output "ami2" {
  description = "AMI of instance"
  value       = aws_instance.server2.ami
}

output "subnets" {
  value = data.aws_subnets.def_vpc_subnets
}
# output "ubuntu_amis" {
#   description = "ubuntu_amis"
#   value       = data.aws_ami_ids.ubuntu_amis
# }

# output "instance_stuff" {
#   description = "all info about instance"
#   value       = aws_instance.server1
# }


## To use for example in IAM policies or retrieving caller identity
data "aws_caller_identity" "current" {

}
output "user_identity" {
  description = "Info about IAM principal used by Terraform to configure AWS"
  value       = data.aws_caller_identity.current
}
