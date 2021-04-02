
resource "kubernetes_deployment" "iotdep" {
  for_each = local.containers

  metadata {
    name = "${each.key}-deployment"
    labels = {
      app = "iotapp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "iotapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "iotapp"
        }
      }

      spec {
        container {
          image = each.value.image
          name  = "${each.key}-container"
          volume_mount {
            name       = "${each.key}-vol"
            mount_path = each.value.volume_path
          }
          port {
            container_port = each.value.int_port
            host_port      = each.value.ext_port
          }
        }
        volume {
          name = "${each.key}-vol"
          empty_dir {
            medium = ""
          }
        }
      }
    }
  }
}
