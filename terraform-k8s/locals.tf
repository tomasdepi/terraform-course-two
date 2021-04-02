
locals {
  containers = {
    nodered = {
      image       = "nodered/node-red:latest"
      int_port    = 1880
      ext_port    = 1880
      volume_path = "/data"
    }
    influxdb = {
      image       = "influxdb"
      int_port    = 8086
      ext_port    = 8086
      volume_path = "/var/lib/influxdb"
    }
    grafana = {
      image       = "grafana/grafana"
      int_port    = 3000
      ext_port    = 3000
      volume_path = "/var/lib/grafana"
    }
  }
}
