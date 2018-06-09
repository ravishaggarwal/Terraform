
terraform {
  backend "s3" {
    bucket = "devrav-terraformexercise2"
    encrypt = true
    region = "us-east-1"
    key    = "devExercise2terraform.tfstate"
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
