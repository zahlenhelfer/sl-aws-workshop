resource "aws_lb_target_group" "ecsTargetGroup" {
  name     = "${var.projectName}-${var.environment}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  load_balancing_algorithm_type = "round_robin"
  slow_start                    = 30 # 30 seconds
  target_type                   = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30 # 30 seconds
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    timeout             = 15 # 15 seconds
    unhealthy_threshold = 3
  }
}

resource "aws_lb" "loadBalancer" {
  name               = "${var.projectName}-${var.environment}-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.loadbalancer.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false
  enable_http2               = true
}

resource "aws_lb_listener" "albTargetListener" {
  load_balancer_arn = aws_lb.loadBalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecsTargetGroup.arn
  }
}
