terraform {
  required_version = "~> 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.6"
    }
  }

  ## Note we cannot use variables here!

  backend "s3" {
    bucket = "acme02-terraform-state-975030449833-dev" # "PUT HERE YOUR BUCKET NAME" - Rafa: "acme02-terraform-state-975030449833-dev"           
    ## Note key is application specific
    key            = "acme02/example-02/terraform.tfstate" # "PUT HERE YOUR APP SPECIFIC PATH (example01)" # "acme02/example-02/terraform.tfstate"  
    dynamodb_table = "acme02-terraform-state-locks-dev"    # "PUT HERE YOUR TABLE NAME" #   "acme02-terraform-state-locks-dev"
    region         = "eu-west-1"
    encrypt        = true
    profile        = "cta"
  }
}

## student00 working example
# backend "s3" {
#   bucket = "acme02-terraform-state-975030449833-dev"
#   ## Note key is application specific
#   key            = "acme02/example-02/terraform.tfstate"
#   dynamodb_table = "acme02-terraform-state-locks-dev"
#   region         = "eu-west-1"
#   encrypt        = true
#   profile        = "cta"
#  }

provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = {
      environment = var.environment
      project     = var.project
      created_by  = "terraform"
      disposable  = true
    }
  }
}


