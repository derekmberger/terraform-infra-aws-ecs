############################
# ECS Cluster & Capacity Providers
############################
resource "aws_ecs_cluster" "cluster" {
  name = "${local.name_prefix}-ecs-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Name = "${local.name_prefix}-ecs-cluster"
  }
}

resource "aws_ecs_capacity_provider" "cp_od" {
  name = "${local.name_prefix}-cp-od"
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg.arn
    managed_termination_protection = "ENABLED"
    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = var.cp_od_capacity_provider_target_capacity
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 100
      instance_warmup_period    = 300
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "cluster_capacity" {
  cluster_name = aws_ecs_cluster.cluster.name
  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT",
    aws_ecs_capacity_provider.cp_od.name,
  ]
  depends_on = [
    aws_ecs_capacity_provider.cp_od,
  ]
}

############################
# EC2 Autoscaling Group & Launch Template
############################
resource "aws_autoscaling_group" "asg" {
  name_prefix               = "${local.name_prefix}-asg-"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 0
  health_check_type         = "EC2"
  health_check_grace_period = 300
  vpc_zone_identifier       = data.terraform_remote_state.vpc_workspace.outputs.private_subnet_ids
  protect_from_scale_in     = true
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  launch_template {
    id      = aws_launch_template.template.id
    version = aws_launch_template.template.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-asg"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}

resource "aws_launch_template" "template" {
  name_prefix   = "${local.name_prefix}-lt-"
  image_id      = var.ec2_instance_ami
  instance_type = var.ec2_instance_type
  key_name      = var.instance_encryption_key_name
  user_data = base64encode(
    templatefile(
      "${path.module}/templates/userdata.sh",
      {
        Environment  = var.environment
        Organization = var.org_name
      }
    )
  )
  vpc_security_group_ids = [aws_security_group.ecs_hosts.id]

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 35
      encrypted   = true
    }
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.instance_profile.arn
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.name_prefix}-launch-template"
    }
  }
}
