# -------------------------------
# GET DEFAULT VPC
# -------------------------------
data "aws_vpc" "default" {
  default = true
}

# -------------------------------
# GET VALID SUBNETS
# -------------------------------
data "aws_subnets" "filtered" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a", "us-east-1b"]
  }
}
