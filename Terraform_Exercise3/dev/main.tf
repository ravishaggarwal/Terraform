
terraform {
  backend "s3" {
    bucket = "devrav-terraformexercise3"
    dynamodb_table = "devravEx3-lock-dynamo"
    encrypt = true
    region = "us-east-1"
    key    = "devExercise3terraform.tfstate"
    profile = "dev"
  }
}


provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  # shared_credentials_file = "%UserProfile%/.aws/credentials"
  region   = "${var.region}"
  profile  = "dev"
}


resource "aws_s3_bucket" "terraform-state-storage-s3" {
    bucket = "devrav-terraformexercise3"
    versioning {
      enabled = true
    }
    lifecycle {
      prevent_destroy = true
    }
    tags {
      Name = "S3 Remote Terraform State Store"
    }
  }

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "devravEx3-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5
  attribute {
    name = "LockID"
    type = "S"
  }
  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}

# Deploy VPC
module "vpc" {
  source       = "../modules/vpc"
  cidr_block = "${var.cidr_block}"
  env = "${var.env_value}"
}

resource "null_resource" "null_id" {
  provisioner "local-exec" {
      command = "echo  VPC is : ${module.vpc.vpcid} >> output.txt"
    }
}
