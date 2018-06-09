resource "aws_vpc" "MYOwnvpc1" {

  cidr_block = "${var.cidr_block}"
  tags {
    Name = "MYOwnvpc1_${var.env}"
  }
}
