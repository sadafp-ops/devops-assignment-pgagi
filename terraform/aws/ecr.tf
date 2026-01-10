resource "aws_ecr_repository" "backend" {
  name                 = "devops-backend"
  force_delete         = true
}

resource "aws_ecr_repository" "frontend" {
  name                 = "devops-frontend"
  force_delete         = true
}
