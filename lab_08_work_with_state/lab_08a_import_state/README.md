Lab 08a - State - Import resources

Existing Terraform configuration includes an EC2 instance and a security group.
The purpose of the exercise/lab is :
1. Create an EC2 instance outside of Terraform (AWS GUI or CLI)
2. Import this EC2 instance into Terraform. For this we need to write a minimal resource, e.g.

resource "aws_instance" "my_imported_instance"
{


}

We will then use the terraform import command,  and if successful explore the state file and verify that it includes the new resource

3. Modify the TF configuration for the new instance (e.g. add a 2nd security group, or add a tag)
Perform plan and apply...

4. Explore the command terraform state mv to move this resource to another aws_instance resource...

terraform state mv aws_instance.my_imported_instance  aws_instance.another_res_name

Explore the documentation for this terraform state mv command.  
Before the mv command,  do you need to create an empty resource for "aws_instance.another_res_name" ?

