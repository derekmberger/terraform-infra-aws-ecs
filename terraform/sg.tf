############################
# Security Group Resources #
############################
resource "aws_security_group" "instance_sg" {
  name        = "${local.name_prefix}-instance-sg"
  description = "ECS host instance SG for ${local.name_prefix}"
  vpc_id      = data.terraform_remote_state.vpc_workspace.outputs.vpc_id

  ingress = [{
    description      = "SSH from ${local.name_prefix}-sshaccess-sg"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc_workspace.outputs.vpc_cidr_block]
    ipv6_cidr_blocks = []
  }]

  egress = [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }]
}

resource "aws_security_group" "sshaccess_sg" {
  name        = "${local.name_prefix}-sshaccess-sg"
  description = "Allow SSH access to ${local.name_prefix} hosts"
  vpc_id      = data.terraform_remote_state.vpc_workspace.outputs.vpc_id

  ingress = []

  egress = [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }]
}
