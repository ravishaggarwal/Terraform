resource "aws_internet_gateway" "myOwnInternetGateway" {
  
  vpc_id = "${var.vpcid_subnet}"
  tags {
    Name = "myOwnInternetGateway_${var.env}"
  }
}
