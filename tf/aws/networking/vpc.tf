terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "terraform"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "terraform"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform"
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}