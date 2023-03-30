
## Note references to outputs of module my_web_vpc
module "web1" {
  #  source            = "../modules/aws-web-server-instance"
  # source            = "github.com/rpgd60/tfcourse-modules//web-modules/aws-web-server-instance"
  # Note below: "ref" in lower case
  source = "github.com/rpgd60/tfcourse-modules//web-modules/aws-web-server-instance?ref=v1.0.2"

  os                = var.server_os
  ec2_instance_type = var.ec2_instance_type
  ec2_instance_name = "web-1-${local.name_suffix}"

  vpc_id        = module.my_web_vpc.vpc_id
  subnet_id     = module.my_web_vpc.subnet_id
  sec_group_ids = [module.my_web_vpc.web_sec_group_id]
}