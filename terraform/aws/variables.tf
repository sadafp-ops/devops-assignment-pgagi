variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "backend_image" {
  type        = string
  description = "ECR backend image URI"
  default     = "dummy"
}

variable "frontend_image" {
  type        = string
  description = "ECR frontend image URI"
  default     = "dummy"
}
