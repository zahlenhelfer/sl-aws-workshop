resource "aws_ecs_task_definition" "hello-world" {
  family                   = "ecs-task-definition-demo"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  container_definitions    = <<EOF
[
  {
    "name": "hello-world-container",
    "image": "nginxdemos/hello",
    "memory": 1024,
    "cpu": 512,
    "essential": true,
    "portMappings": [
      {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
      }
    ]
  }
]
EOF
}
