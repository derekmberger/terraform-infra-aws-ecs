#############################
# Terraform Cloud Resources #
#############################
resource "tfe_workspace" "workspace" {
  name                          = "infra-aws-ecs-${var.region_code}-${var.environment}"
  organization                  = var.tfc_organization
  auto_apply                    = var.tfc_workspace_auto_apply
  queue_all_runs                = false
  terraform_version             = var.terraform_version
  structured_run_output_enabled = false
  working_directory             = var.vcs_repo_terraform_working_directory

  vcs_repo {
    identifier     = var.vcs_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
    branch         = var.vcs_branch
  }
}

resource "tfe_workspace_settings" "allow_remote_reference" {
  workspace_id              = tfe_workspace.workspace.id
  global_remote_state       = true
}
