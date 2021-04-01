
output "lb_endpoint" {
  value = module.loadbalancing.lb_endpoint
}

output "instances" {
  value = {
    for x in module.compute.instance : x.tags.Name => "${x.public_ip}:${module.compute.target_group_port}"
  }
  sensitive = true
}

output "kubeconfig_file" {
  value     = module.compute.kubeconfig_files
  sensitive = true
}
