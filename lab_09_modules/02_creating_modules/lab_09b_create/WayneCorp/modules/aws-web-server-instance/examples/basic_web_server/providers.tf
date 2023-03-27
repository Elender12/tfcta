terraform {
  required_version = "~> 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.13" # v3.38.0 minimal version to use default tags
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}