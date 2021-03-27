
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
