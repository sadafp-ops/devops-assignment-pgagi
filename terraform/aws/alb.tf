############################################
# Application Load Balancer
############################################
resource "aws_lb" "app" {
  name               = "assignment-alb"
  load_balancer_type = "application"
  internal           = false

  # IMPORTANT:
  # We DO NOT attach security_groups here
  # because ALB already exists and was imported
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
