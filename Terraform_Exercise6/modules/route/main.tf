resource "aws_route_table" "PublicRoutes" {
  
  vpc_id = "${var.vpcid_subnet}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.createdIGW}"
  }

  tags {
    Name = "PublicRoutes_${var.env}"
  }
}

#resource "aws_default_route_table" "PrivateRoutes" {
  #default_route_table_id = "${var.defaultRouteTableId}"

  #tags {
  #  Name = "PrivateRoutes"
  #}
#}

resource "aws_route_table_association" "route_public_association" {
  count          = "${var.subnet_Count}"
  subnet_id      = "${var.all_subnet_ids[count.index]}"
  route_table_id = "${aws_route_table.PublicRoutes.id}"
}
