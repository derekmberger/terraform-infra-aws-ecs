######################
# AWS Data Providers #
######################
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

##################################
# Terraform Cloud Data Providers #
##################################
data "terraform_remote_state" "vpc_workspace" {
  backend = "remote"
  config = {
    organization = var.org_name
    workspaces = {
      name = "infra-aws-vpc-${var.region_code}-${var.environment}"
    }
  }
}
