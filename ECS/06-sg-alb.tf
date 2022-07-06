# container only allows the loadbalancer as a source of traffic.
resource "aws_security_group" "allow-http-from-lb" {
  name        = "allow-http-from-lb"
  description = "Allow HTTP from loadbalancer"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    security_groups = [aws_security_group.loadbalancer.id]
  }
}

# loadbalancer allows access from everywhere.
resource "aws_security_group" "loadbalancer" {
  name        = "alb-http"
  description = "alb security group for http access"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
