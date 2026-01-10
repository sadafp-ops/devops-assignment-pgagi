terraform {
  backend "s3" {
    bucket         = "149916142098-devops-assignment-tf-state"
    key            = "aws/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
