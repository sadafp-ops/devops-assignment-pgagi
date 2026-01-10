############################################
# Application Load Balancer
############################################
resource "aws_lb" "app" {
  name               = "assignment-alb"
  load_balancer_type = "application"
  internal           = false

  # ALB already exists (imported)
  subnets = data.aws_subnets.public.ids

  tags = {
    Project     = "devops-assignment"
    Environment = "staging"
  }
}
############################################
# HTTP Listener
############################################
resource "aws_lb_listener" "http" {
  depends_on        = [aws_lb.app]
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      status_code  = "404"
      content_type = "text/plain"
      message_body = "Not Found"
    }
  }
}
############################################
# Backend Target Group
############################################
resource "aws_lb_target_group" "backend" {
  name        = "backend-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
############################################
# Frontend Target Group
############################################
resource "aws_lb_target_group" "frontend" {
  name        = "frontend-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.main.id
  target_type = "ip"

  health_check {
    path = "/"
  }
}
############################################
# Listener Rule → Backend
############################################
resource "aws_lb_listener_rule" "backend" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }

  condition {
    path_pattern {
      values = ["/api/*", "/health"]
    }
  }
}
############################################
# Listener Rule → Frontend
############################################
resource "aws_lb_listener_rule" "frontend" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
