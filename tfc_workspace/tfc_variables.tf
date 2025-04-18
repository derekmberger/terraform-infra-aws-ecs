####################
# Project Variables #
#####################
resource "tfe_variable" "aws_region" {
  category     = "terraform"
  key          = "aws_region"
  value        = var.aws_region
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "region_code" {
  category     = "terraform"
  key          = "region_code"
  value        = var.region_code
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "environment" {
  category     = "terraform"
  key          = "environment"
  value        = var.environment
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "tfc_workspace_name" {
  category     = "terraform"
  key          = "tfc_workspace_name"
  value        = tfe_workspace.workspace.name
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "vcs_repo" {
  category     = "terraform"
  key          = "vcs_repo"
  value        = var.vcs_repo
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "org_name" {
  category     = "terraform"
  key          = "org_name"
  value        = var.org_name
  workspace_id = tfe_workspace.workspace.id
}

############################
# Custom Project Variables #
############################
resource "tfe_variable" "ec2_instance_type" {
  category     = "terraform"
  key          = "ec2_instance_type"
  value        = var.ec2_instance_type
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "ec2_instance_ami" {
  category     = "terraform"
  key          = "ec2_instance_ami"
  value        = var.ec2_instance_ami
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "instance_encryption_key_name" {
  category     = "terraform"
  key          = "instance_encryption_key_name"
  value        = var.instance_encryption_key_name
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "cp_od_capacity_provider_target_capacity" {
  category     = "terraform"
  key          = "cp_od_capacity_provider_target_capacity"
  value        = var.cp_od_capacity_provider_target_capacity
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "arm_ec2_instance_ami" {
  category     = "terraform"
  key          = "arm_ec2_instance_ami"
  value        = var.arm_ec2_instance_ami
  workspace_id = tfe_workspace.workspace.id
}
