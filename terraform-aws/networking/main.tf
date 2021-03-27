
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

resource "aws_subnet" "public_subnet" {
  count = length(var.public_cidrs)

  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_cidrs[count.index]
  map_public_ip_on_launch = true

  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
}
