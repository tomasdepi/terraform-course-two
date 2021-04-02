
//--------------------------------------------------------------------
// Variables



//--------------------------------------------------------------------
// Modules
module "compute" {
  source  = "app.terraform.io/depi/compute/aws"
  version = "1.1.0"

  aws_region          = "us-east-2"
  public_key_material = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC27k2XUpckWvP2+WpYwITP1dr2cJjAXBmxhvrbaVoCAIesNgTBbpztzgR3Q7gkZPz/tD+yy/NUvzV2ki6AL5ePOx4b556b/jtoprElL8vloG04vYt2oG6A+RMrWp9MT4y5pWOKcRueHDf0BrDsHeXHSGAdpg7Z7NUkbwXxpkyP941n3U/2IIpvv0PW2gc6JGRmgdjKvNt+/FXlIYIROQYNjjLLG88k4tWsDjI9nQqCjkZk4Qv/IRfyrLwSA5OLlHtMi4EaPZJFkBtkaWlux13kFtAyxom7p1Db4jYCSf3kgO1UcR2LHb2rPIQYjzH47fUqw1ylIj1Mwa672UIO5sm1 /home/psf/.ssh/tdepietro"
  public_sg           = module.networking.public_sg
  public_subnets      = module.networking.public_subnets
}

module "networking" {
  source  = "app.terraform.io/depi/networking/aws"
  version = "1.0.0"

  access_ip  = "0.0.0.0/0"
  aws_region = "us-east-2"
}
