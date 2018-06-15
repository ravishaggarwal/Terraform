
terraform {
  backend "s3" {
    bucket = "devrav-terraformexercise6"
    encrypt = true
    region = "us-east-1"
    key    = "devExercise6terraform.tfstate"
   }
}

# provider informaiton
provider "aws" {
  region     = "${var.region}"
assume_role {
    role_arn = "arn:aws:iam::xxxxxxxxxxx:role/xxxxxxxxxxx"
  }

}

# Deploy VPC
module "vpc" {
  source       = "../modules/vpc"
  cidr_block = "${lookup(var.cidr_block,var.env_value)}"
  env = "${var.env_value}"
}

# Deploy subnet
module "subnet" {
  source       = "../modules/subnet"
  vpcid_subnet = "${module.vpc.vpcid}"
  cidrblock_subnet = "${module.vpc.cidrblock}"
  env = "${var.env_value}"

}

# Deploy Internet Gateway
module "internetgateway" {
  source       = "../modules/internetgateway"
  vpcid_subnet = "${module.vpc.vpcid}"
  env = "${var.env_value}"

}

# Deploy Internet Gateway
module "route" {
  source       = "../modules/route"
  vpcid_subnet = "${module.vpc.vpcid}"
  subnet_Count= "${module.subnet.subnet_Count}"
  all_subnet_ids= "${module.subnet.all_subnet_ids}"
  #defaultRouteTableId = "${module.vpc.defaultRouteTableId}"
  createdIGW  = "${module.internetgateway.InternetGateway}"
  env = "${var.env_value}"

}

# Deploy Internet Gateway
module "securitygroup" {
  source       = "../modules/securitygroup"
  vpcid_subnet = "${module.vpc.vpcid}"
  subnet_Count= "${module.subnet.subnet_Count}"
  subnet_ips= "${module.subnet.subnet_ips}"
  env = "${var.env_value}"
}

# Create s3 bucket
module "storage" {
  source       = "../modules/storage"
  env = "${var.env_value}"
}

module "instance"{
  source  = "../modules/instance"
  SecurityGroupName= "${module.securitygroup.SecurityGroupName}"
  all_subnet_ids= "${module.subnet.all_subnet_ids}"
  env = "${var.env_value}"
}



resource "null_resource" "null_id" {
  provisioner "local-exec" {
      command = "echo  VPC is : ${module.vpc.vpcid} >> output.txt"
	  }
	 provisioner "local-exec" {
      command = "echo  Subnets are : ${module.subnet.subnet_ids} >> output.txt"
      } provisioner "local-exec" {
	  command = "echo Internet Gateways is : ${module.internetgateway.InternetGateway} >> output.txt"
		 } provisioner "local-exec" {
	 command = "echo Internet Gateways is : ${module.storage.bucketname} >> output.txt"
	  } provisioner "local-exec" {
      command = "echo Route is : ${module.route.RouteOutput} >> output.txt"
	   } provisioner "local-exec" {
      command = "echo Route is : ${module.securitygroup.SecurityGroupName} >> output.txt"
	}
  }



