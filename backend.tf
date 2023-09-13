terraform {
  backend "s3" {
    bucket = "terraform-cicd2-project"
    key    = "terraform/backend"
    region = "us-east-1"

  }
}