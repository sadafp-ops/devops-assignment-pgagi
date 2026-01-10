variable "aws_region" {
  description = "AWS Region"
  default     = "eu-north-1"
}

variable "project_name" {
  default = "devops-assignment"
}

variable "frontend_image" {
  description = "ECR frontend image URI"
}

variable "backend_image" {
  description = "ECR backend image URI"
}
