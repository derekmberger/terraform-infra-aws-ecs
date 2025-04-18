output "ecs_cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.cluster.arn
}

output "iamrole_ecs_exec_arn" {
  value = aws_iam_role.ecs_exec_role.arn
}

output "iamrole_ecs_exec_id" {
  value = aws_iam_role.ecs_exec_role.id
}

output "ecs_capacity_provider_name" {
  value = aws_ecs_capacity_provider.cp_od.name
}

output "ecs_host_instance_sg" {
  value = aws_security_group.instance_sg.id
}
