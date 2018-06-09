output "vpcid" {
  value = "${aws_vpc.MYOwnvpc1.id}"
}

output "cidrblock" {
  value = "${aws_vpc.MYOwnvpc1.cidr_block}"
}
