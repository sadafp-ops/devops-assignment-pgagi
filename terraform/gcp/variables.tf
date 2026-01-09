variable "project_id" {
  description = "GCP Project ID"
}

variable "region" {
  description = "GCP Region"
  default     = "asia-south1"
}

variable "backend_image" {
  description = "Docker Hub backend image"
}

variable "frontend_image" {
  description = "Docker Hub frontend image"
}
