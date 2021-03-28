
locals {
  vpc_cidr = "10.0.0.0/16"
}

module "vpc" {
  source = "./networking"

  vpc_cidr             = local.vpc_cidr
  public_subnet_count  = 2
  private_subnet_count = 3
  public_cidrs         = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs        = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
}
