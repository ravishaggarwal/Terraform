
data "aws_availability_zones" "available" {

}

resource "aws_subnet" "myOwnsubnet" {

count      = 2
vpc_id     = "${var.vpcid_subnet}"
 cidr_block = "${cidrsubnet(var.cidrblock_subnet, 8, count.index)}"
 availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
 tags {
   Name = "myOwnsubnet_${count.index}_${var.env}"
 }

}
