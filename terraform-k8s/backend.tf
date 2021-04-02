
terraform {
  backend "remote" {
    organization = "depi"

    workspaces {
      name = "k8s"
    }
  }
}
