
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group[*].name
}

output "db_security_group" {
  value = aws_security_group.security_groups["rds"].id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "public_security_group" {
  value = aws_security_group.security_groups["public"].id
}
