
variable "vpc_cidr" {
  type = string
}

variable "public_cidrs" {
  type = list(any)
}

variable "private_cidrs" {
  type = list(any)
}

variable "public_subnet_count" {
  type = number
}

variable "private_subnet_count" {
  type = number
}

variable "access_ip" {
  type = string
}

variable "security_groups" {
  type = map(any)
}

variable "db_subnet_group" {
  type = bool
}
