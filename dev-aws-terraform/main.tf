resource "aws_vpc" "robert-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "robert_public_subnet" {
  vpc_id                  = aws_vpc.robert-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"

  tags = {
    Name = "dev-public"
  }

}

resource "aws_internet_gateway" "robert_internet_gateway" {
  vpc_id = aws_vpc.robert-vpc.id

  tags = {

    Name = "dev-igw"
  }
}

resource "aws_route_table" "robert_public_rt" {
  vpc_id = aws_vpc.robert-vpc.id

  tags = {

    Name = "dev_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.robert_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.robert_internet_gateway.id
}


resource "aws_route_table_association" "robert_public_assoc" {
  subnet_id      = aws_subnet.robert_public_subnet.id
  route_table_id = aws_route_table.robert_public_rt.id
}

resource "aws_security_group" "robert_sg" {
  name        = "dev_sg"
  vpc_id      = aws_vpc.robert-vpc.id
  description = "dev security group"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["31.164.97.105/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}