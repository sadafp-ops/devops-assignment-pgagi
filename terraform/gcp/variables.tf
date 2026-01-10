variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "backend_image" {
  description = "Backend image URI"
  type        = string
}

variable "frontend_image" {
  description = "Frontend image URI"
  type        = string
}
