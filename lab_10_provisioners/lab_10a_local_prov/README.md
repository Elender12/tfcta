## Example of Local provisioner

NOTE: Terraform discourages the use of provisioners
https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax#provisioners-are-a-last-resort

Shows two creation time provisioners and a destroy time  provisioner

The first creation-time provisioners creates (if not existing) a subdirectory "temp" under the current directory, 
The second creation-time provisioner then writes for each instance:

Server 1: IP address is 172.31.41.116
Server 0: IP address is 172.31.26.137
(...)

"self" is used to refer to the parent object (in this example aws_instance.server)

A single command is allowed inside a provisioner

The creation-time provisioner runs only the first time the instance is created, not when there are updates.

The destroy-time provisioner destroys the directory


