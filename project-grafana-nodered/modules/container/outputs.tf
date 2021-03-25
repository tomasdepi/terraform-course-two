
output "application_access" {
  value = {
    for x in docker_container.container[*] :
    x.name => join(":", [x.ip_address, x.ports[0].external])
  }
}
