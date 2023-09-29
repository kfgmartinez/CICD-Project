resource "aws_vpc" "CICD2" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "CICD2-vpc"
  }
}

resource "aws_subnet" "CICD2-pub-1" {
  vpc_id                  = aws_vpc.CICD2.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "CICD2-pub-1"
  }
}

resource "aws_subnet" "CICD2-pub-2" {
  vpc_id                  = aws_vpc.CICD2.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "CICD2-pub-2"
  }
}



resource "aws_subnet" "CICD2-priv-1" {
  vpc_id                  = aws_vpc.CICD2.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "CICD2-priv-1"
  }
}


resource "aws_subnet" "CICD2-priv-2" {
  vpc_id                  = aws_vpc.CICD2.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "CICD2-priv-2"
  }
}



resource "aws_internet_gateway" "CICD2-IGW" {
  vpc_id = aws_vpc.CICD2.id
  tags = {
    Name = "CICD2-IGW"
  }
}

resource "aws_route_table" "CICD2-pub-RT" {
  vpc_id = aws_vpc.CICD2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.CICD2-IGW.id
  }

  tags = {
    Name = "CICD2-pub-RT"
  }
}


resource "aws_route_table_association" "CICD2-pub-1-a" {
  subnet_id      = aws_subnet.CICD2-pub-1.id
  route_table_id = aws_route_table.CICD2-pub-RT.id
}

resource "aws_route_table_association" "CICD2-pub-2-a" {
  subnet_id      = aws_subnet.CICD2-pub-2.id
  route_table_id = aws_route_table.CICD2-pub-RT.id
}

#################################################################################################################

module "eks" {
  source = "../EKS"
  vpc_id = aws_vpc.CICD2.id
  subnet_ids = [aws_subnet.CICD2-pub-1.id, aws_subnet.CICD2-pub-2.id]
  securitygroup_ids = module.EKS_sg.security_group_public
}

module "EKS_sg" {
    source = "../EKS_sg"
    vpc_id  =  aws_vpc.CICD2.id
}