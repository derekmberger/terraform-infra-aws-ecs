locals {
  name_prefix = "${var.org_name}-${var.environment}"

  # Managed policies for EC2 instance role
  instance_role_managed_policies = [
    "AmazonEC2ReadOnlyAccess",
    "service-role/AmazonEC2ContainerServiceAutoscaleRole",
    "service-role/AmazonEC2ContainerServiceforEC2Role",
    "CloudWatchAgentServerPolicy",
    "AmazonSSMManagedInstanceCore",
    "AmazonEC2ContainerRegistryReadOnly",
  ]

  # Managed policies for ECS task exec role
  ecs_exec_managed_policies = [
    "service-role/AmazonECSTaskExecutionRolePolicy",
    "AmazonEC2ContainerRegistryReadOnly",
    "AmazonSSMReadOnlyAccess",
  ]
}
