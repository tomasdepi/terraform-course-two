
variable "db_storage" {
  type = number
}

variable "db_engine_version" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_name" {
  type      = string
  sensitive = true
}

variable "db_user" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_subnet_group_name" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(any)
}

variable "db_identifier" {
  type = string
}

variable "skip_final_snapshot" {
  type = bool
}
