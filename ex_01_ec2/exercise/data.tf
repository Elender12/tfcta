variable "profile" {
  type    = string
  default = "cta"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "my_ami" {
  description = "ami for EC2 instance"
  type        = string
  default     = "ami-0b752bf1df193a6c4"
}


## VPC parameters
variable "vpc_cidr" {
  type    = string
  default = "10.99.0.0/16"
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr)) ## Needs work
    error_message = "Invalid CIDR for VPC."
  }
}
/*- Local variables :  use a local variable to construct a "name suffix" that you will use in:
    - The "Name" label of EC2 instance and security group constructs
    - The name of the security group
*/

locals {
  service_name = "ele-service"
  owner = "Elena"
  # Ids for multiple sets of EC2 instances, merged together
  #instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service = local.service_name
    Owner   = local.owner
  }
}