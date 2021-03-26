
locals {
  deployments = {
    nodered = {
      container_count = length(var.ext_port["nodered"][terraform.workspace])
      image           = var.image_names["nodered"][terraform.workspace]
      int_port        = 1880
      ext_port        = var.ext_port["nodered"][terraform.workspace]
      volumes = [
        { container_path_each = "/data" }
      ]
    }
    influxdb = {
      container_count = length(var.ext_port["influxdb"][terraform.workspace])
      image           = var.image_names["influxdb"][terraform.workspace]
      int_port        = 8086
      ext_port        = var.ext_port["influxdb"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/influxdb" }
      ]
    }
    grafana = {
      container_count = length(var.ext_port["grafana"][terraform.workspace])
      image           = var.image_names["grafana"][terraform.workspace]
      int_port        = 3000
      ext_port        = var.ext_port["grafana"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/grafana" },
        { container_path_each = "/etc/grafana" }
      ]
    }
  }
}

module "images" {
  source = "./modules/image"

  for_each   = local.deployments
  image_name = each.value.image
}

module "container" {
  source   = "./modules/container"
  for_each = local.deployments

  count_in    = each.value.container_count
  name_in     = each.key
  image_in    = module.images[each.key].image_name
  int_port_in = each.value.int_port
  ext_port_in = each.value.ext_port
  volumes_in  = each.value.volumes
}
