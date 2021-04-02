
data "terraform_remote_state" "terraform-aws" {
  backend = "remote"

  config = {
    organization = "depi"
    workspaces = {
      name = "terraform-course-dev"
    }
  }
}
