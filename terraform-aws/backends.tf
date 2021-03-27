
terraform {
  backend "remote" {
    organization = "depi"

    workspaces {
      name = "terraform-course-dev"
    }
  }
}
