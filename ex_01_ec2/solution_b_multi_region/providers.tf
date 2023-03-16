terraform {
  required_version = "~> 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.13" # v3.38.0 minimal version to use default tags
    }
  }
}

provider "aws" {
  region  = var.region1
  profile = var.profile
  default_tags {
    tags = {
      "${var.company}:environment" = var.environment
      "${var.company}:project"     = var.project
      created_by                   = "terraform"
      disposable                   = true
    }
  }
}

provider "aws" {
  alias = "region2"
  region  = var.region2
  profile = var.profile
  default_tags {
    tags = {
      "${var.company}:environment" = var.environment
      "${var.company}:project"     = var.project
      created_by                   = "terraform"
      disposable                   = true
      additional_tag = "viva el Betis"
    }
  }
}