
output "container_ip_addresses" {
  value = [
    for x in docker_container.nodered_container[*] :
    join(":", [x.ip_address, x.ports[0].external])
  ]

  description = "Private Ip Address and port of the container"
}

output "container_names" {
  value       = docker_container.nodered_container[*].name
  description = "Container's Name"
}
