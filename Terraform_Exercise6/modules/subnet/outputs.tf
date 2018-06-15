output "all_subnet_ids" {
  value = "${aws_subnet.myOwnsubnet.*.id}"
}

output "subnet_id_0" {
  value = "${aws_subnet.myOwnsubnet.*.id[0]}"
}

output "subnet_id_1" {
  value = "${aws_subnet.myOwnsubnet.*.id[1]}"
}

output "subnet_Count" {
  value = "${aws_subnet.myOwnsubnet.count}"
}

output "subnet_ids" {
value = "${join(", ", aws_subnet.myOwnsubnet.*.id)}"
}

output "subnet_ips" {
  value = "${aws_subnet.myOwnsubnet.*.cidr_block}"
}
