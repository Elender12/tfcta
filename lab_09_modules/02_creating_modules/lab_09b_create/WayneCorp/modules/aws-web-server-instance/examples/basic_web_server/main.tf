
## Create an auxiliary VPC
module "vpc_test" {
  source            = "../../../../modules/aws-web-vpc"
  vpc_name = "test_2"
  subnet_name = "sub_2"
  vpc_cidr_block    = "10.99.0.0/16"
  subnet_cidr_block = "10.99.100.0/24"
}

## Note references to outputs of module aws_web_vpc
module "web_test" {
  source            = "../../../../modules/aws-web-server-instance"
  os                = "ubuntu"
  ec2_instance_type = "t2.micro"
  ec2_instance_name = "web-test"

  vpc_id        = module.vpc_test.vpc_id
  subnet_id     = module.vpc_test.subnet_id
  sec_group_ids = [module.vpc_test.web_sec_group_id]
}
