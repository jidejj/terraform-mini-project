terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "eu-west-2"
  access_key = "AKIA2UZBSXI4N7RZNG6K"
  secret_key = var.secret_key
}

resource "aws_vpc" "inst_vpc" {
  cidr_block             = "10.0.0.0/16"
  enable_dns_support     = true
  enable_dns_hostnames   = true

  tags = {
    Name = "inst_vpc"
  }
}

resource "aws_internet_gateway" "inst_internet_gateway" {
  vpc_id = aws_vpc.inst_vpc.id

  tags = {
    Name = "inst_internet_gateway"
  }
}

resource "aws_route_table" "inst-route-table-public" {
  vpc_id = aws_vpc.inst_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.inst_internet_gateway.id
  }

  tags = {
    Name = "inst-route-table-public"
  }
}

resource "aws_subnet" "inst-public-subnet1" {
  vpc_id                  = aws_vpc.inst_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "inst-public-subnet1"
  }
}

resource "aws_subnet" "inst-public-subnet2" {
  vpc_id                  = aws_vpc.inst_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "inst-public-subnet2"
  }
}

resource "aws_route_table_association" "inst-public-subnet1-association" {
  subnet_id      = aws_subnet.inst-public-subnet1.id
  route_table_id = aws_route_table.inst-route-table-public.id
}

resource "aws_route_table_association" "inst-public-subnet2-association" {
  subnet_id      = aws_subnet.inst-public-subnet2.id
  route_table_id = aws_route_table.inst-route-table-public.id
}

resource "aws_network_acl" "inst-network_acl" {
  vpc_id     = aws_vpc.inst_vpc.id
  subnet_ids = [aws_subnet.inst-public-subnet1.id, aws_subnet.inst-public-subnet2.id]

  ingress {
    rule_no      = 100
    protocol     = "-1"
    action       = "allow"
    cidr_block   = "0.0.0.0/0"
    from_port    = 0
    to_port      = 0
  }

  egress {
    rule_no      = 100
    protocol     = "-1"
    action       = "allow"
    cidr_block   = "0.0.0.0/0"
    from_port    = 0
    to_port      = 0
  }
}
