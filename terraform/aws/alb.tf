####################################
# APPLICATION LOAD BALANCER
####################################
resource "aws_lb" "app" {
  name               = "assignment-alb"
  load_balancer_type = "application"
  internal           = false

  security_groups = [aws_security_group.alb.id]

  # ALB requires at least 2 subnets in 2 AZs
   subnets = [
    aws_subnet.public_1a.id,
    aws_subnet.public_1b.id
  ]
  depends_on = [
    aws_internet_gateway.igw,
    aws_route_table_association.public_1a,
    aws_route_table_association.public_1b
  ]
}

####################################
# HTTP LISTENER
####################################
resource "aws_lb_listener" "http" {
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

####################################
# BACKEND TARGET GROUP
####################################
resource "aws_lb_target_group" "backend" {
  name        = "backend-tg"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    path                = "/health"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

####################################
# FRONTEND TARGET GROUP
####################################
resource "aws_lb_target_group" "frontend" {
  name        = "frontend-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id
}

####################################
# LISTENER RULES
####################################
resource "aws_lb_listener_rule" "backend" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  condition {
    path_pattern {
      values = ["/api/*", "/health"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}

resource "aws_lb_listener_rule" "frontend" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 20

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}
