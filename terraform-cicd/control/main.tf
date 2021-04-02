
locals {
  aws_creds = {
    AWS_ACCESS_KEY_ID     = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
  }
  organization = "depi"
}

resource "github_repository" "repo" {
  name             = "terraform-dev-repo"
  description      = "vpc and compute resources"
  auto_init        = true
  license_template = "mit"

  visibility = "private"
}

resource "github_branch_default" "default" {
  repository = github_repository.repo.name
  branch     = "main"
}

resource "github_repository_file" "main" {
  repository          = github_repository.repo.name
  branch              = "main"
  file                = "main.tf"
  content             = file("deployments/dev/main.tf")
  commit_message      = "Managed by Terraform"
  commit_author       = "Depi"
  commit_email        = "tomas@depi.com"
  overwrite_on_create = true
}

resource "tfe_oauth_client" "oauth" {
  organization     = local.organization
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = "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"
  service_provider = "github"
}

resource "tfe_workspace" "workspace" {
  name         = github_repository.repo.name
  organization = local.organization
  vcs_repo {
    identifier    = "${var.github_owner}/${github_repository.repo.name}"
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }
}

resource "tfe_variable" "aws_creds" {
  for_each = local.aws_creds

  key          = each.key
  value        = each.value
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.workspace.id
}
