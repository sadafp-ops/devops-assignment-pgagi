output "alb_url" {
  value = aws_lb.app.dns_name
}
output "backend_ecr_repo" {
  value = aws_ecr_repository.backend.repository_url
}

output "frontend_ecr_repo" {
  value = aws_ecr_repository.frontend.repository_url
}
