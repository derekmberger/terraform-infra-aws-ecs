#Disregarded by TFC but used for planning locally
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "biotornic"

    workspaces {
      prefix = "infra-aws-ecs-"
    }
  }
}
