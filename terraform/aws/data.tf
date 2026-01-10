data "aws_vpc" "main" {
  id = "vpc-0952bdfcfc86ec686"
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}
