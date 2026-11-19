resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = local.tags
}


# Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = local.tags
}


# Subnets

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = local.tags
}

# resource "aws_subnet" "private" {
#   vpc_id = aws_vpc.vpc.id
#   cidr_block = "10.0.2.0/24"
# }


# Route tables and associations

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = local.tags
}

# resource "aws_route_table" "private_rt" {
#   vpc_id = aws_vpc.vpc.id
# }

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public.id
}

# resource "aws_route_table_association" "private_rt" {
#   route_table_id = aws_route_table.private_rt.id
#   subnet_id = aws_subnet.private_sub.id
# }


# Security Groups

# resource "aws_security_group" "sg" {
#   name        = "tf-security-group"
#   description = "public security group"
#   vpc_id      = aws_vpc.vpc.id
# }

# resource "aws_vpc_security_group_ingress_rule" "http" {
#   security_group_id = aws_security_group.sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   to_port           = 80
#   ip_protocol       = "-1"
# }

# resource "aws_vpc_security_group_ingress_rule" "https" {
#   security_group_id = aws_security_group.sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
#   to_port           = 443
# }

