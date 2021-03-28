
locals {
  vpc_cidr = "10.0.0.0/16"
  security_groups = {
    public = {
      name = "public_sg"
      ingress = {
        ssh = {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        http = {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
    rds = {
      name = "rds_sg"
      ingress = {
        sql = {
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
        }
      }
    }
  }
}

module "vpc" {
  source = "./networking"

  vpc_cidr             = local.vpc_cidr
  public_subnet_count  = 2
  private_subnet_count = 3
  public_cidrs         = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs        = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  access_ip            = var.access_ip
  security_groups      = local.security_groups
  db_subnet_group      = true
}

module "database" {
  source                 = "./database"
  db_storage             = 10
  db_engine_version      = "5.7.22"
  db_instance_class      = "db.t2.micro"
  db_name                = var.db_name
  db_user                = var.db_user
  db_password            = var.db_password
  db_identifier          = "my-db"
  skip_final_snapshot    = true
  db_subnet_group_name   = module.vpc.db_subnet_group_name[0]
  vpc_security_group_ids = [module.vpc.db_security_group]
}
