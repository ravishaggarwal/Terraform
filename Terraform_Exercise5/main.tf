terraform {
  backend "s3" {
    bucket = "sampleassumerolewiths3"
    encrypt = true
    region = "us-east-1"
    key    = "sampleassumeterraform.tfstate"
  }
}


provider "aws" {
  region   = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::xxxxxxxx:role/xxxxxxx"
    }

}
resource "aws_vpc" "Mvpc1" {

  cidr_block = "10.0.0.0/24"
  tags {
    Name = "MYOwnvpc1Dev"
  }
}
