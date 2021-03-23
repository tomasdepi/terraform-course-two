
variable "image_name" {
  description = "Image Name"
  type        = map(any)
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}
