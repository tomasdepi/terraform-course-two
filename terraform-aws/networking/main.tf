
data "aws_availability_zones" "available_zones" {
  state = "available"
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available_zones.names
  result_count = max(var.public_subnet_count, var.private_subnet_count)
}

resource "aws_subnet" "public_subnet" {
  count = var.public_subnet_count

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true

  availability_zone = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "public_subnet-${count.index + 1}"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "private_subnet" {
  count = var.private_subnet_count

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false

  availability_zone = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "private_subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_internet_gateway.id
}

resource "aws_default_route_table" "private_rt" {
  default_route_table_id = aws_vpc.main_vpc.default_route_table_id

  tags = {
    Name = "private_route_table"
  }
}

resource "aws_security_group" "security_groups" {
  for_each = var.security_groups
  name     = each.value.name
  vpc_id   = aws_vpc.main_vpc.id

  dynamic "ingress" {
    for_each = each.value.ingress

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  count      = var.db_subnet_group ? 1 : 0
  name       = "rds_subnet_group"
  subnet_ids = aws_subnet.private_subnet[*].id

  tags = {
    Name = "RDS subnet group"
  }
}
