## Mandatory variables 

variable "ec2_instance_name" {
  type    = string
}

variable "os" {
  description = "ubuntu or amazon_linux"
  validation {
    condition     = contains(["ubuntu", "amazon_linux"], var.os)
    error_message = "Valid values for os: unbuntu or amazon_linux."
  } 
}

variable "ec2_instance_type" {
  description = "Instance type for web server EC2 instance"
  type        = string
   validation {
    condition = anytrue([
      var.ec2_instance_type == "t2.micro",
      var.ec2_instance_type == "t3.micro"
    ])
    error_message = "Instance type must be t2.micro or t3.micro "
  }
}


variable "vpc_id" {
  description = "VPC id"
  type = string
}

variable "subnet_id" {
  description = "subnet id"
  type = string
}

variable "sec_group_ids" {
  description = "security group id"
  type = list(string)
  default = []
}

