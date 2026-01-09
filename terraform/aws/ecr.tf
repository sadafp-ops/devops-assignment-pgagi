resource "aws_ecr_repository" "backend" {
  name = "devops-backend"
}

resource "aws_ecr_repository" "frontend" {
  name = "devops-frontend"
}
