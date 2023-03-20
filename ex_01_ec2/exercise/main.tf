#declare provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  profile = var.profile
  region  = var.region
  default_tags {
    tags = {
      Environment = "Learning"
      Owner       = "Elena"
      Project     = "First exercise"
    }
  }
}



#declare resources
resource "aws_instance" "first_instance" {
  ami           = var.my_ami
  instance_type = var.instance_type
  tags = {
    Name = "first-${local.service_name}"
  }
}
resource "aws_instance" "second_instance" {
  ami           = var.my_ami
  instance_type = var.instance_type
  tags = {
    Name = "second-${local.service_name}"
  }
}

resource "aws_vpc" "example" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "my-vpc-resource"
  }
}