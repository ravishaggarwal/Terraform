output "Subnet Names" {
  value = "${join(", ", module.subnet.all_subnet_ids)}"
}

output "VPC Name" {
  value = "${module.vpc.vpcid}"
}

output "INternetGateway Name" {
  value = "${module.internetgateway.InternetGateway}"
}

output "Route Name" {
  value = "${module.route.RouteOutput}"
}

output "Storage Name" {
  value = "${module.storage.bucketname}"
}

output "Security Group Name" {
  value = "${module.securitygroup.SecurityGroupName}"
}

output "Instances Created" {
  value = "${module.instance.server_id}"
}
