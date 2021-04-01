
output "instance" {
  value     = aws_instance.node[*]
  sensitive = true
}

output "target_group_port" {
  value = var.target_group_port
}
