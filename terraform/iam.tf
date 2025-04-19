############################
# EC2 Instance Role
############################
resource "aws_iam_role" "instance_role" {
  name                  = "${local.name_prefix}-ecs-instance-role"
  description           = "Allows EC2 instances to call AWS services on your behalf."
  path                  = "/"
  max_session_duration  = 3600
  force_detach_policies = false

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "instance_role_attach" {
  for_each   = toset(local.instance_role_managed_policies)
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/${each.value}"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${local.name_prefix}-ecs-instance-profile"
  role = aws_iam_role.instance_role.name
}

############################
# ECS Task Execution Role
############################
resource "aws_iam_role" "ecs_exec_role" {
  name                 = "${local.name_prefix}-ecs-exec-role"
  path                 = "/"
  max_session_duration = 3600

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_exec_role_attach" {
  for_each   = toset(local.ecs_exec_managed_policies)
  role       = aws_iam_role.ecs_exec_role.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/${each.value}"
}
