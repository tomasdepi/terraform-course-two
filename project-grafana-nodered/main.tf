
locals {
  deployments = {
    nodered = {
      image = var.image_names["nodered"][terraform.workspace]
    }
    influxdb = {
      image = var.image_names["influxdb"][terraform.workspace]
    }
  }
}

module "images" {
  source     = "./modules/image"
  
  for_each = local.deployments
  image_name = each.value.image
}

module "container" {
  source     = "./modules/container"

  name_in = "nodered-${terraform.workspace}"
  image_in = module.images["nodered"].image_name
  int_port_in = var.int_port
  ext_port_in = var.ext_port
  container_path_in = var.container_path
}
