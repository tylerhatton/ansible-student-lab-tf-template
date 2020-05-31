data "aws_availability_zones" "available" {
  state = "available"
}

# Internet VPC
resource "aws_vpc" "ansible_student_lab" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "${var.name_prefix}-ansible_student_lab"
  }
}

# Subnets
resource "aws_subnet" "ansible_student_mgmt" {
  vpc_id                  = aws_vpc.ansible_student_lab.id
  cidr_block              = var.management_net_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.name_prefix}-ansible_student_mgmt"
  }
}

# Internet GW
resource "aws_internet_gateway" "ansible_student_gw" {
  vpc_id = aws_vpc.ansible_student_lab.id

  tags = {
    Name = "${var.name_prefix}-ansible_student_gw"
  }
}

resource "aws_route_table" "ansible_student_public" {
  vpc_id = aws_vpc.ansible_student_lab.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ansible_student_gw.id
  }

  tags = {
    Name = "${var.name_prefix}-ansible_student_public"
  }
}

resource "aws_route_table_association" "ansible_student_public" {
  subnet_id      = aws_subnet.ansible_student_mgmt.id
  route_table_id = aws_route_table.ansible_student_public.id
}