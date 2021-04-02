
terraform {
    backend "remote" {
        organization = "depi"

        workspaces {
            name = "terraform-dev-repo"
        }
    }
}