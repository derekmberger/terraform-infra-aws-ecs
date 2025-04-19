############################
# Security Group Resources #
############################
resource "aws_security_group" "ecs_hosts" {
  name        = "${local.name_prefix}-ecs-hosts-sg"
  description = "Management SG for ECS EC2 hosts (${local.name_prefix})"
  vpc_id      = data.terraform_remote_state.vpc_workspace.outputs.vpc_id

  # ─── SSH Ingress (manually edit this CIDR if you need SSH) ───
  # ingress {
  #   description = "SSH from trusted admin IP"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["203.0.113.45/32"]
  # }

  egress {
    description = "All outbound (for SSM, ECS agent, CloudWatch, etc.)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.name_prefix}-ecs-hosts-sg"
  }
}
