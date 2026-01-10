terraform {
  backend "s3" {
    bucket = "149916142098-devops-assignment-tf-state"
    key    = "gcp/terraform.tfstate"
    region = "eu-north-1"
  }
}
