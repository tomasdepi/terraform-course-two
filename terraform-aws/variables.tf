
variable "aws_region" {
  default = "us-east-2"
  type    = string
}

variable "access_ip" {
  type = string
}

# ---- Database Variables ----

variable "db_name" {
  type = string
}

variable "db_user" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}
