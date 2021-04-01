
variable "instance_count" {
  type = number
}

variable "instance_type" {
  type = string
}

variable "public_sg" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "volume_size" {
  type = number
}

variable "key_name" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "user_data_path" {
  type = string
}

variable "db_user" {
  type = string
}
variable "db_pass" {
  type      = string
  sensitive = true
}

variable "db_endpoint" {
  type = string
}

variable "db_name" {
  type = string
}

variable "lb_target_group_arn" {
  type = string
}

variable "target_group_port" {
  type = number
}
