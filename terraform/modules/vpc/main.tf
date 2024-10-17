locals {
    public_subnet_id = [aws_subnet.public_subnet2.id, aws_subnet.public_subnet1.id]
}
resource "aws_vpc" "main" {
 cidr_block           = "10.0.0.0/24"
 enable_dns_hostnames = true
 tags = {
   name = "${var.app_name}-vpc"
 }
}

resource "aws_subnet" "public_subnet1" {
 vpc_id                  = aws_vpc.main.id
 cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 2, 0) 
 map_public_ip_on_launch = true
 availability_zone       = "eu-west-1a"
}

resource "aws_subnet" "public_subnet2" {
 vpc_id                  = aws_vpc.main.id
 cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 2, 1) 
 map_public_ip_on_launch = true
 availability_zone       = "eu-west-1b"
}


resource "aws_internet_gateway" "internet_gateway" {
 vpc_id = aws_vpc.main.id
 tags = {
   Name = "internet_gateway"
 }
}

resource "aws_route_table" "route_table" {
 vpc_id = aws_vpc.main.id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.internet_gateway.id
 }
}

resource "aws_route_table_association" "subnet_route" {
 subnet_id      = aws_subnet.public_subnet1.id
 route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_route" {
 subnet_id      = aws_subnet.public_subnet2.id
 route_table_id = aws_route_table.route_table.id
}
