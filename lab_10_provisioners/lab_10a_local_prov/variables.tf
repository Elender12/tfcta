## AWS Specific parameters

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "profile" {
  type    = string
  default = "cta"
}

variable "lab_number" {
  type    = string
  default = "ex02"
}

## specific for "count"
variable "num_instances" {
  type    = number
  default = 2
}
## Environment and Project
variable "company" {
  type        = string
  description = "company name - will be used in tags"
  default     = "acme"
}
variable "environment" {
  type        = string
  description = "e.g. test dev prod"
  default     = "dev"
}

variable "project" {
  type    = string
  default = "proj99"
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

variable "num_azs" {
  type        = number
  description = "Number of AZs to distribute instances"
  default     = 2
  validation {
    condition     = var.num_azs >= 1 && var.num_azs <= 3
    error_message = "Invalid number of AZs to distribute instances"
  }
}
## EC2 Instance Parameters

variable "instance_type" {
  type    = string
  default = "t2.micro"
}


# variable "key_name" {
#   type = string
#   default = "tf-course"
# }


## Security Groups
variable "sec_allowed_external" {
  description = "CIDRs from which access is allowed"
  type        = list(string)
  default     = ["0.0.0.0/0"]
  # default = ["2.37.1.5/32"]
}

## ECS Parameters
variable "special_port" {
  type        = string
  description = "TCP port where Foobar application listens"

}

