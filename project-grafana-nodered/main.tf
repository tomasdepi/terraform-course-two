
module "image" {
  source     = "./modules/image"
  image_name = var.image_name[terraform.workspace]
}
