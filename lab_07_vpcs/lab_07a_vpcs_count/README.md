Lab - VPCs using count

We review using count "loops" in a different context :  subnets inside a VPC

Try to create

A VPC with a specfic CIDR (subnet)
Three sets of subnets :  public,  private and database,   representing a typical 3-tier scenario
In each tier we create two subnets, each in one Availability Zone (AX)

We obtain the AZs using yet another data source,  using the region as a parameter
