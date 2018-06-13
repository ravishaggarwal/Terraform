terraform {
  backend "s3" {
    bucket = "sampleassumerolewiths3"
    encrypt = true
    region = "us-east-1"
    key    = "sampleassumeterraform.tfstate"
    #profile = "dev"
  }
}


provider "aws" {
#  access_key = "${var.access_key}"
 # secret_key = "${var.secret_key}"
  # shared_credentials_file = "%UserProfile%/.aws/credentials"
  region   = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::578517095658:role/adminrole"
    }

}

#  profile  = "dev"
#}

# Deploy VPC
# module "vpc" {
 # source       = "../modules/vpc"
  #cidr_block = "${var.cidr_block}"
#  env = "${var.env_value}"
#}

resource "aws_vpc" "Mvpc1" {

  cidr_block = "10.0.0.0/24"
  tags {
    Name = "MYOwnvpc1Dev"
  }
}
