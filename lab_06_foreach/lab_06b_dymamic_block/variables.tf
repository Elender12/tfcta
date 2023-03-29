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
  type = string
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


