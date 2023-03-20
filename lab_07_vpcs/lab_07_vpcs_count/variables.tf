## AWS Specific parameters

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "profile" {
  type    = string
  default = "cta"
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

variable "lab_number" {
  type    = string
  default = "put-a-lab-number-here"
}

## VPC and subnet parameters

## VPC parameters
variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr)) ## Needs work
    error_message = "Invalid CIDR for VPC."
  }
}

variable "public_subnets" {
  type        = list(string)
  description = "list of subnets used for public subnets"
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_subnets" {
  type        = list(string)
  description = "list of subnets used for private subnets"
  default     = ["10.10.10.0/23", "10.10.12.0/23"]
}

variable "db_subnets" {
  type        = list(string)
  description = "list of subnets used for database subnets"
  default     = ["10.10.201.0/24", "10.10.202.0/24"]
}


## EC2 Instance Parameters

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "tf-course"
}


## Security Groups
variable "sec_allowed_external" {
  description = "CIDRs from which access is allowed"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

## ECS Parameters
variable "special_port" {
  type = string
}

