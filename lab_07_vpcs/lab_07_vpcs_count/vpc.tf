
resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "vpc-${local.name_suffix}" }
}

resource "aws_subnet" "public_subnet" {
  count                = length(var.public_subnets)
  availability_zone_id = local.az_id[count.index]
  vpc_id               = aws_vpc.vpc1.id
  cidr_block           = var.public_subnets[count.index]
  tags                 = { "tier" = "public", "Name" = "public-${local.name_suffix}-${count.index}" }

}

resource "aws_subnet" "private_subnet" {
  count                = length(var.private_subnets)
  availability_zone_id = local.az_id[count.index]
  vpc_id               = aws_vpc.vpc1.id
  cidr_block           = var.private_subnets[count.index]

  tags =  { "tier" = "private", "Name" = "private-${local.name_suffix}-${count.index}" }
}

resource "aws_subnet" "db_subnet" {
  count                = length(var.db_subnets)
  availability_zone_id = local.az_id[count.index]
  vpc_id               = aws_vpc.vpc1.id
  cidr_block           = var.db_subnets[count.index]

  tags =  { "tier" = "database", "Name" = "database-${local.name_suffix}-${count.index}" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id
  tags =  { "Name" = "igw-${local.name_suffix}" }
}

resource "aws_eip" "nat_ip" {
  count      = length(var.public_subnets)
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags       = { "Name" = "eip-${count.index}" }
}

resource "aws_nat_gateway" "natgw" {
  count         = length(var.public_subnets) 
  allocation_id = aws_eip.nat_ip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  tags          =  { "Name" = "natgw-${local.name_suffix}-${count.index}" }

}

resource "aws_route_table" "public_subnet_rt" {
  count  = length(var.public_subnets)
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { "Name" = "public-${local.name_suffix}-${count.index}" }
}

resource "aws_route_table_association" "pub" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_subnet_rt[count.index].id
}

resource "aws_route_table" "private_subnet_rt" {
  count  = length(var.private_subnets)
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw[count.index].id
  }
  tags = { "Name" = "private-${local.name_suffix}-${count.index}" }
}


resource "aws_route_table_association" "priv" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_subnet_rt[count.index].id
}

resource "aws_route_table" "db_subnet_rt" {
  count  = length(var.db_subnets)
  vpc_id = aws_vpc.vpc1.id
  tags   = { "Name" = "database-${count.index}" }
}

resource "aws_route_table_association" "db" {
  count = length(var.db_subnets)

  subnet_id      = aws_subnet.db_subnet[count.index].id
  route_table_id = aws_route_table.db_subnet_rt[count.index].id
}
