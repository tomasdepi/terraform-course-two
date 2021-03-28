
resource "aws_lb" "lb" {
  name            = "my-loadbalancer"
  subnets         = var.public_subnets
  security_groups = [var.public_sg]
  idle_timeout    = 400
}

