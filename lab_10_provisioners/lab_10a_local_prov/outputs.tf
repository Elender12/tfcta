output "public_ip" {
  description = "Public IP of instance"
  value       = aws_instance.server[*].public_ip
}


# output "ami" {
#   description = "AMI of instance"
#   value       = aws_instance.server[*].ami
# }

output "instance_id" {
  description = "Id of instance"
  value       = aws_instance.server[*].id
}

output "id_ip" {
  description = "Instance Id and Public IP"
  value = zipmap(aws_instance.server[*].id, aws_instance.server[*].public_ip)
}
