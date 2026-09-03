# Vpc

resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc-cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "Vpc-resume-app"
    env  = "dev"
    Team = "devops"
  }
}
// internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "IWG"
  }
  # depends_on = [aws_vpc.vpc1]
}

# public subnet
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-1a"
  }
}
resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Public-1b"
  }
}


# private subnet
resource "aws_subnet" "sub3" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Private-1a"
  }
}
resource "aws_subnet" "sub4" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Private-1b"
  }
}
// Nat Gateway
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.sub1.id

  tags = {
    Name = "gw NAT"
  }
}

// Elastic ip for Nat Gateway

resource "aws_eip" "eip"  {

}
# public route table

#  Create the Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "public-route-table"
  }
}

# Create a Route pointing all out-bound traffic to the IGW
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Associate the Route Table with the Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc2" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.public_rt.id
}

# route and association for priavate subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "private-route-table"
  }
}

# Create a Route pointing all out-bound traffic to the IGW
resource "aws_route" "private_internet_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat1.id
}

# Associate the Route Table with the Private Subnet
resource "aws_route_table_association" "private_subnet_assoc" {
  subnet_id      = aws_subnet.sub3.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_subnet_assoc2" {
  subnet_id      = aws_subnet.sub4.id
  route_table_id = aws_route_table.private_rt.id
}


# create a sub domain in route 53
/*
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.id
  name    = "terraform.bandenkop.store"
  type    = "A"
  ttl     = 300
  records = ["200.10.19.34"]

}
*/