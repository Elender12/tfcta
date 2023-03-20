# output "public_ip" {
#   description = "Public IP of instance"
#   value       = aws_instance.server[*].public_ip
# }

# output "key_name" {
#   description = "SSH Key Name"
#   value       = aws_instance.server.key_name
# }

# output "ami" {
#   description = "AMI of instance"
#   value       = aws_instance.server[*].ami
# }

# output "instance_stuff" {
#   description = "all info about instance"
#   value       = aws_instance.server2
# }

output "instance_id" {
  description = "Id of instance"
  value       =  [for k, instance in aws_instance.server2 : instance.id]

}

output "instance_ip" {
  description = "public IP of instance"
  value       =  [for k, pepe in aws_instance.server2 : pepe.public_ip]

}

output "id_ip_version1" {
  value = [for k, i in aws_instance.server2 : "Mapping: ${i.id} to ${i.public_ip}}" ]
}


output "id_ip_version2" {
  value = {for paco, i in aws_instance.server2 : i.id => i.public_ip }
}

output "ip_dns_version1" {
  value = zipmap(local.test3, local.test6)
}

output "ip_dns_vesion2" {
  value = local.test7
}






# output "dns_map" {
#   value = [for k in server1 : server1[k].public_ip]
# }


## To use for example in IAM policies or retrieving caller identity
data "aws_caller_identity" "current" {

}
output "user_identity" {
  description = "Info about IAM principal used by Terraform to configure AWS"
  value       = data.aws_caller_identity.current
}


