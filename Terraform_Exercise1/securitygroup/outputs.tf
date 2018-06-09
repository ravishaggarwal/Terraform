output "SecurityGroupName" {
  value = "${join(", ", aws_security_group.mySecurityGroup.*.id)}"
}
