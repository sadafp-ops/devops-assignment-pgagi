resource "aws_ecr_repository" "backend" {
  name                 = "devops-backend01"
  force_delete         = true
}

resource "aws_ecr_repository" "frontend" {
  name                 = "devops-frontend01"
  force_delete         = true
}
