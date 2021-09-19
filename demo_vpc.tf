#Creating VPC

resource "aws_vpc" "demovpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = { "Name" = "demovpc" }
}

#Creating Public Subnets
#Public Subnet-1

resource "aws_subnet" "demo_public_subnet_1" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags                    = { "Name" = "demo_public_subnet_1" }
}

#Public Subnet-2
resource "aws_subnet" "demo_public_subnet_2" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true
  tags                    = { "Name" = "demo_public_subnet_2" }
}

#Creating Private Subnets
#Private Subnet-1
resource "aws_subnet" "demo_private_subnet_1" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = false
  tags                    = { "Name" = "demo_private_subnet_1" }
}

#Private Subnet-2
resource "aws_subnet" "demo_private_subnet_2" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = false
  tags                    = { "Name" = "demo_private_subnet_2" }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demovpc.id
  tags   = { "Name" = "demo_igw" }
}

# Creating elastic IP for NAT Gateway
resource "aws_eip" "demo_eip" {
  vpc  = true
  tags = { "Name" = "demo_eip" }
}


# Creating NAT gateway
resource "aws_nat_gateway" "demo_ngw" {
  allocation_id = aws_eip.demo_eip.id
  subnet_id     = aws_subnet.demo_private_subnet_1.id
  tags          = { "Name" = "demo_ngw" }
}

# Creating Route tables
# Creating public route table
resource "aws_route_table" "demo_public_route_table" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = { "Name" = "demo_public_route_table" }
}

# Creating private route table
resource "aws_route_table" "demo_private_route_table" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demo_ngw.id
  }

  tags = { "Name" = "demo_private_route_table" }
}


# Creating route table associations
resource "aws_route_table_association" "demo_public_rt_association_1" {
  subnet_id      = aws_subnet.demo_public_subnet_1.id
  route_table_id = aws_route_table.demo_public_route_table.id
}

resource "aws_route_table_association" "demo_public_rt_association_2" {
  subnet_id      = aws_subnet.demo_public_subnet_2.id
  route_table_id = aws_route_table.demo_public_route_table.id
}

resource "aws_route_table_association" "demo_private_rt_association_1" {
  subnet_id      = aws_subnet.demo_private_subnet_1.id
  route_table_id = aws_route_table.demo_private_route_table.id
}

resource "aws_route_table_association" "demo_private_rt_association_2" {
  subnet_id      = aws_subnet.demo_private_subnet_2.id
  route_table_id = aws_route_table.demo_private_route_table.id
}
# Creating a Network ACL
resource "aws_network_acl" "nacl" {
  vpc_id     = aws_vpc.demovpc.id
  subnet_ids = [aws_subnet.demo_public_subnet_1.id, aws_subnet.demo_public_subnet_2.id, aws_subnet.demo_private_subnet_1.id, aws_subnet.demo_private_subnet_2.id]
  tags       = { "Name" = "nacl" }
}

resource "aws_network_acl_rule" "nacl_rule_ingress" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "nacl_rule_egress" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}