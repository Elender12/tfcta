## Mandatory variables

variable "vpc_name" {
  type    = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for webserer VPC"
}

variable "subnet_cidr_block" {
  type    = string
}

variable "subnet_name" {
  type    = string
}

## Optional variables

variable "aws_az" {
  type    = string
  default = "eu-west-1a"
}

variable "igw_name" {
  type    = string
  default = "web_server_igw"
}

variable "rt_name" {
  type    = string
  default = "web_server_rt"
}


