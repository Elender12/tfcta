Lab - Using 3rd Party Modules

This lab explores using Terraform modules created by third parties.

We use the very popular "official" Terraform module
- VPC: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest


The initial configuration contains a vpc created with the module.
Look for the lines:

```
module "vpc_one" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.1"

  name               = "vpc-${local.name_suffix}-1"
  cidr               = var.vpc_cidr1
  enable_nat_gateway = false
  single_nat_gateway = true

  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = var.public_subnets1  ## local.two_pub_subnets
  private_subnets = var.private_subnets1 ## local.two_priv_subnets

}
```

Think of this configuration as "calling" a module function that is available at: "terraform-aws-modules/vpc/aws"
We are calling the function with 8 parameters, named:
  name   
  cidr 
  enable_nat_gateway
  single_nat_gateway
  azs     
  public_subnets  
  private_subnets  

The result of calling this is a "construct"  that we are calling "vpc_one"  
IMPORTANT: "vpc_one"  is an arbitrary name we have chosen; terwe could also call it "primera_vpc" (or "foobar")

The "module call" has created a number of resources as we expected:  vpc, subnets, internet gateway etc...
We can see them if we run terraform state list.  The names are somewhat strange and new to us, but underneath they are really resources.

module.vpc_one.aws_internet_gateway.this[0]
module.vpc_one.aws_route.public_internet_gateway[0]
module.vpc_one.aws_route_table.private[0]
module.vpc_one.aws_route_table.public[0]
module.vpc_one.aws_route_table_association.private[0]
module.vpc_one.aws_route_table_association.private[1]
module.vpc_one.aws_route_table_association.public[0]
module.vpc_one.aws_route_table_association.public[1]
module.vpc_one.aws_subnet.private[0]
module.vpc_one.aws_subnet.private[1]
module.vpc_one.aws_subnet.public[0]
module.vpc_one.aws_subnet.public[1]
module.vpc_one.aws_vpc.this[0]

So far we have seen how to call the module with "input" variables.

The modules have also "output" variables - 
The official VPC module has 100+ possible outputs but not all are available (depending on our input values)

