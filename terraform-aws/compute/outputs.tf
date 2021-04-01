
output "instance" {
  value     = aws_instance.node[*]
  sensitive = true
}

output "target_group_port" {
  value = var.target_group_port
}

output "kubeconfig_files" {
  value = {
    for x in aws_instance.node : x.tags.Name => "${x.tags.Name}.yaml"
  }
  sensitive = true
}
