data "aws_vpc" "main" {
  id = "vpc-00101d48fb39d0286"
}

data "aws_subnet" "public_1a" {
  id = "subnet-0e337bacafd5d9cf9"
}

data "aws_subnet" "public_1b" {
  id = "subnet-0bdf3a3a7f959466f"
}
