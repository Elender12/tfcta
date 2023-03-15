terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
      # version = "< 4.0"
    }
  }
  required_version = ">= 1.3.0"
  # required_version = "< 1.3"
}

provider "aws" {
  profile = "cta"
  region  = "eu-west-1"
}

variable "my_ami" {
  description = "ami for EC2 instance"
  type        = string
  default     = "ami-0b752bf1df193a6c4"
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
  default     = "t2.micro"
}

variable "project" {
  type    = string
  default = "proj99"
}

## Create instance - will use defaults for parameters not specified (e.g. VPC, security group)
resource "aws_instance" "server1" {
  ami           = var.my_ami
  instance_type = var.instance_type

  tags = {
    Name    = "vm1"
    project = var.project
  }
}



output "instance_stuff" {
  description = "all info about instance"
  value       = aws_instance.server1
}

output "instance_id" {
  description = "now only the instance ID"
  value       = aws_instance.server1.id
}

