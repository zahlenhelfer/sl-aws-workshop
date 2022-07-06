# ECR-Repository URL
output "ecr-repository-url" {
  value = aws_ecr_repository.repository.repository_url
}

output "ecsTaskExecution-Role-arn" {
  value = aws_iam_role.ecsTaskExecutionRole.arn
}

output "targetGroupArn" {
  value = aws_lb_target_group.ecsTargetGroup.arn
}
