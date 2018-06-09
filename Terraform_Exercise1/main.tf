
# provider informaiton
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# Deploy VPC
module "vpc" {
  source       = "./vpc"
  cidr_block = "${lookup(var.cidr_block,var.env_value)}"
  env = "${var.env_value}"
}

# Deploy subnet
module "subnet" {
  source       = "./subnet"
  vpcid_subnet = "${module.vpc.vpcid}"
  cidrblock_subnet = "${module.vpc.cidrblock}"
  env = "${var.env_value}"

}

# Deploy Internet Gateway
module "internetgateway" {
  source       = "./internetgateway"
  vpcid_subnet = "${module.vpc.vpcid}"
  env = "${var.env_value}"

}

# Deploy Internet Gateway
module "route" {
  source       = "./route"
  vpcid_subnet = "${module.vpc.vpcid}"
  subnet_Count= "${module.subnet.subnet_Count}"
  all_subnet_ids= "${module.subnet.all_subnet_ids}"
  #defaultRouteTableId = "${module.vpc.defaultRouteTableId}"
  createdIGW  = "${module.internetgateway.InternetGateway}"
  env = "${var.env_value}"

}

# Deploy Internet Gateway
module "securitygroup" {
  source       = "./securitygroup"
  vpcid_subnet = "${module.vpc.vpcid}"
  subnet_Count= "${module.subnet.subnet_Count}"
  subnet_ips= "${module.subnet.subnet_ips}"
  env = "${var.env_value}"
}

# Create s3 bucket
module "storage" {
  source       = "./storage"
  env = "${var.env_value}"
}

module "instance"{
  source  = "./instance"
  SecurityGroupName= "${module.securitygroup.SecurityGroupName}"
  all_subnet_ids= "${module.subnet.all_subnet_ids}"
  env = "${var.env_value}"
}


resource "null_resource" "null_id" {
  provisioner "local-exec" {
      command = "echo  VPC is : ${module.vpc.vpcid} >> output.txt"
      command = "echo  Subnets are : ${module.subnet.subnet_ids} >> output.txt"
      command = "echo Internet Gateways is : ${module.internetgateway.InternetGateway} >> output.txt"
      command = "echo Internet Gateways is : ${module.storage.bucketname} >> output.txt"
      command = "echo Route is : ${module.route.RouteOutput} >> output.txt"
      command = "echo Route is : ${module.securitygroup.SecurityGroupName} >> output.txt"

  }
}
