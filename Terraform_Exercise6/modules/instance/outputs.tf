output "server_id" {
  value = "${join(", ", aws_instance.myInstance.*.id)}"
}

output "server_ip" {
  value = "${join(", ", aws_instance.myInstance.*.public_ip)}"
}
