
variable "image_names" {
  description = "Image Name"
  type        = map(any)
  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
  }
}

variable "container_count" {
  type    = number
  default = 2
}

variable "ext_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.ext_port > 1500 && var.ext_port < 2000
    error_message = "The internal port must be between 1500 and 2000."
  }
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The internal port must be 1880."
  }
}

variable "container_path" {
  type    = string
  default = "/data"
}

variable "host_path" {
  type    = string
  default = ""
}
