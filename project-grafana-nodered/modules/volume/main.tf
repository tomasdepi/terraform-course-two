
resource "docker_volume" "volume" {
  count = var.volume_count

  name = "${var.volume_name}-${count.index}"
  lifecycle {
    prevent_destroy = false
  }
}
