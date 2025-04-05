resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "dev-vpc"
  }
}