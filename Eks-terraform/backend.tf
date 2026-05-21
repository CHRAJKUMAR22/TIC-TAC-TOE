terraform {
  backend "s3" {
    bucket         = "raju-mrcloudbook777"
    key            = "EKS/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
