resource "aws_ecs_cluster" "cluster" {
  name = "${var.projectName}-${var.environment}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

}

resource "aws_ecs_service" "hello-world" {
  name            = "hello-worl-app"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.hello-world.arn
  launch_type     = "FARGATE"
  network_configuration {
    # module.vpc.public_subnets[0].id
    subnets          = ["${element(module.vpc.public_subnets, 0)}", "${element(module.vpc.public_subnets, 1)}"]
    security_groups  = [aws_security_group.allow-http.id]
    assign_public_ip = true
  }
  desired_count = 1
}
