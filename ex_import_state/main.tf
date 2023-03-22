terraform {
  required_version = "~> 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.13" # v3.38.0 minimal version to use default tags
    }
  }
}


variable "profile" {
  type    = string
  default = "cta"

}

variable "company" {
  type    = string
  default = "slinkynet"

}

variable "region" {
  type    = string
  default = "eu-west-1"

}

provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = {

      disposable = true
    }
  }
}

resource "aws_instance" "myvm" {
  ami = "unknown"
  instance_type = "unknown"
}