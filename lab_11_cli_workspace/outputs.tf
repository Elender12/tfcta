output "public_ip" {
  description = "Public IP of instance"
  value       = aws_instance.server[*].public_ip
}



output "instance_id" {
  description = "Id of instance"
  value       = aws_instance.server[*].id
}

output "id_ip" {
  description = "Instance Id and Public IP"
  value       = zipmap(aws_instance.server[*].id, aws_instance.server[*].public_ip)
}

output workspace_name {
  description = "Active workspace"
  value = terraform.workspace
}
output num_instances_ws {
  description = "Number of instances for this workspace"
  value = lookup(var.num_instances, terraform.workspace)
}

output instance_type_ws {
  description = "Instance type for this workspace"
  value = lookup(var.instance_type, terraform.workspace)
}