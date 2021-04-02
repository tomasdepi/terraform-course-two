
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.3"
    }
  }
}

provider "kubernetes" {
  config_path = "../${data.terraform_remote_state.terraform-aws.outputs.kube}"
}
