############################
# Security Group Resources #
############################
resource "aws_security_group" "instance_sg" {
  name        = "${local.name_prefix}-instance-sg"
  description = "ECS host instance SG for ${local.name_prefix}"
  vpc_id      = data.terraform_remote_state.vpc_workspace.outputs.vpc_id

  ingress = [{
    cidr_blocks      = [data.terraform_remote_state.vpc_workspace.outputs.vpc_cidr_block]
    description      = "SSH from ${local.name_prefix}-sshaccess-sg"
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups = []
    self    = false
    to_port = 22
  }]

  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
}

resource "aws_security_group" "sshaccess_sg" {
  name        = "${local.name_prefix}-sshaccess-sg"
  description = "Allow SSH access to ${local.name_prefix} hosts"
  vpc_id      = data.terraform_remote_state.vpc_workspace.outputs.vpc_id
  ingress = []
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
}
