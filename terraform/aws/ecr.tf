resource "aws_ecr_repository" "backend" {

  name                 = "devops-backend02"
  force_delete         = true
}

resource "aws_ecr_repository" "frontend" {
  name                 = "devops-frontend02"
  force_delete         = true

  
}

