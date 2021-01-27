variable "VPCCIDR" {
  type        = string
}
variable "SubnetsPUB1CIDR" {
  type        = string
}
variable "SubnetsPUB2CIDR" {
  type        = string
}
variable "SubnetsPRV1CIDR" {
  type        = string
}
variable "SubnetsPRV2CIDR" {
  type        = string
}

resource "aws_vpc" "VPC" {
    cidr_block = var.VPCCIDR
    enable_dns_support = "true"
    enable_dns_hostnames = "false"
    instance_tenancy = "default"
}

resource "aws_internet_gateway" "InternetGateway" {
    vpc_id = aws_vpc.VPC.id
}

resource "aws_subnet" "SubnetsPUB1" {
    availability_zone = "ap-northeast-1a"
    cidr_block = var.SubnetsPUB1CIDR
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.VPC.id
}

resource "aws_subnet" "SubnetsPUB2" {
    availability_zone = "ap-northeast-1c"
    cidr_block = var.SubnetsPUB2CIDR
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.VPC.id
}

resource "aws_subnet" "SubnetsPRV1" {
    availability_zone = "ap-northeast-1a"
    cidr_block = var.SubnetsPRV1CIDR
    vpc_id = aws_vpc.VPC.id
}

resource "aws_subnet" "SubnetsPRV2" {
    availability_zone = "ap-northeast-1c"
    cidr_block = var.SubnetsPRV2CIDR
    vpc_id = aws_vpc.VPC.id
}

resource "aws_route_table" "PublicRouteTable" {
    vpc_id = aws_vpc.VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.InternetGateway.id
    }
}

resource "aws_route_table_association" "SubnetsPUB1" {
    subnet_id = aws_subnet.SubnetsPUB1.id
    route_table_id = aws_route_table.PublicRouteTable.id
}

resource "aws_route_table_association" "SubnetsPUB2" {
    subnet_id = aws_subnet.SubnetsPUB2.id
    route_table_id = aws_route_table.PublicRouteTable.id
}
