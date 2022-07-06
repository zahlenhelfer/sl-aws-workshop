resource "aws_ecs_service" "hello-world-alb" {
  name                               = "hello-world-app-alb"
  cluster                            = aws_ecs_cluster.cluster.id
  task_definition                    = aws_ecs_task_definition.hello-world-alb.arn
  desired_count                      = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.allow-http-from-lb.id]
    subnets          = ["${element(module.vpc.private_subnets, 0)}", "${element(module.vpc.private_subnets, 1)}"]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecsTargetGroup.arn
    container_name   = "hello-world-container-alb"
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }

  depends_on = [aws_lb_listener.albTargetListener]

}
