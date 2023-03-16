## Objective

Create 2 EC2 Instances in default vpc  (hint: use data source for default vpc)

- AMI :  latest ubuntu 2022.04  -  use data source 

- Security group : start with the "integrated" SG like we have seen so far that includes the ingress and egress rules inside the SG resource. 


- Local variables :  use a local variable to construct a "name suffix" that you will use in:
    - The "Name" label of EC2 instance and security group constructs
    - The name of the security group

- Make sure that the security group has a lifecycle rule to enforce "create before destroy" if the SG needs to be replaced


Once you have created the two instances , lets modify the TF configuration so that:


The instances will be in different Availability Zones (AZs)
- Tip:  In AWS you assign an AZ based on the subnet   (hint: aws_subnet data source)
- To get an idea of what is in the aws_subnet - use output
- What do you think will happen when you do "terraform plan"? Make a guess and then verify it

## More advanced options



1. Deploy Multi Region

Create another two EC2 instances with the same parameters in another region (eu-central-1) -- you have to use eu-central-1 due to IAM policies in SSO permission sets.

- Hint:  use provider aliases
Docs: https://developer.hashicorp.com/terraform/language/providers/configuration

- To make this exercise simpler,  remove references to security groups from the instance definition. This means the EC2 instances will use automatically the default SG from the default VPC in each region


You can also explore the use of "count" to create more than one, but we will see this in another lab.

2. Another way to define SGs

1.  Security Group

Create a new SG  the "recommended" way: 
    - One aws_security_group resource for the security group
    - Use aws_vpc_security_group_ingress_rule  and aws_vpc_security_group_egress_rule for each rule
    - Make sure the names of the two security group do not "collide"
    - Point the instances to the new SG