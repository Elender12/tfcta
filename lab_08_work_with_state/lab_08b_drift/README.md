This lab follows HashiCorp's tutorial "Manage Resource Drift" at
https://developer.hhicorp.com/terraform/tutorials/state/resource-drift

Variables modified to align with course
- region -> eu-west-1


Command to generate ssh key pair  (you can keep the example.com email)
This command must be run in the same directory you have the terraform files

ssh-keygen -t rsa -C "your_email@example.com" -f ./key

Commands to introduce drift :   add --profile cta   to all AWS Commands:

e.g.
export SG_ID=$(aws ec2 create-security-group --group-name "sg_web" --description "allow 8080" --output text --profile cta)

aws ec2 authorize-security-group-ingress --group-name "sg_web" --protocol tcp --port 8080 --cidr 0.0.0.0/0 --profile cta


aws ec2 modify-instance-attribute --instance-id $(terraform output -raw instance_id) --groups $SG_ID --profile cta

