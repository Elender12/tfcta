Lab 06 

Preliminary concepts - objects - see also lab 05


Exploring the test1 and test2 locals  (note that we can define as many "locals" blocks as we want and where we want)

The first local definition (test1) generates an object - note the brackets "{ }"
The second (test2) generates a list - note "[ ]"


locals {
  instance_info = {
    dep1 = "t2.micro"
    dep2 = "t3.micro"
    dep3 = "t3.micro"
    "department 4" = "t2.micro"
  }

  test1 = { for key, val in local.instance_info : upper(key) => upper(val)}
  test2 = [for clave, valor in local.instance_info : "Maps ${clave} to ${valor}"]
}

(base) rp4:lab_06_ec2_foreach$ echo local.test1 | terraform console 
{
  "DEP1" = "T2.MICRO"
  "DEP2" = "T3.MICRO"
  "DEP3" = "T3.MICRO"
  "DEPARTMENT 4" = "T2.MICRO"
}
(base) rp4:lab_06_ec2_foreach$ echo local.test2 | terraform console 
[
  "Maps dep1 to t2.micro",
  "Maps dep2 to t3.micro",
  "Maps dep3 to t3.micro",
  "Maps department 4 to t2.micro",
]

Notice that the "key" and "value" variables can have any name  (key,value) (clave, valor -- in Spanish) as long as the whole is consistent

Now do terraform plan and apply and play with some of the variables defined in file ec2.tf

(base) rp4:lab_06_ec2_foreach$ echo local.test3 | terraform console 
[
  "52.17.151.212",
  "18.202.25.174",
  "63.33.191.217",
  "18.203.138.92",
]
(base) rp4:lab_06_ec2_foreach$ echo local.test4 | terraform console 
{
  "ec2-18-202-25-174.eu-west-1.compute.amazonaws.com" = "18.202.25.174"
  "ec2-18-203-138-92.eu-west-1.compute.amazonaws.com" = "18.203.138.92"
  "ec2-52-17-151-212.eu-west-1.compute.amazonaws.com" = "52.17.151.212"
  "ec2-63-33-191-217.eu-west-1.compute.amazonaws.com" = "63.33.191.217"
}
(base) rp4:lab_06_ec2_foreach$ echo local.test5 | terraform console 
{
  "i-017da083a8f10d585" = {
    "ec2-18-203-138-92.eu-west-1.compute.amazonaws.com" = "18.203.138.92"
  }
  "i-0528a46374063b1d3" = {
    "ec2-18-202-25-174.eu-west-1.compute.amazonaws.com" = "18.202.25.174"
  }
  "i-086be0f3224531554" = {
    "ec2-52-17-151-212.eu-west-1.compute.amazonaws.com" = "52.17.151.212"
  }
  "i-09016e3485d4cce3d" = {
    "ec2-63-33-191-217.eu-west-1.compute.amazonaws.com" = "63.33.191.217"
  }
}

