provider "aws" {
region = "us-east-1"
assume_role {
    role_arn = "arn:aws:iam::xxxxxxxxxx:role/xxxxxxx"
    }
}
resource "aws_vpc" "Mvpc1" {

  cidr_block = "10.0.0.0/24"
  tags {
    Name = "MYOwnvpc1Dev"
  }
}
