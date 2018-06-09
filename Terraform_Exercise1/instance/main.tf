data "aws_ami" "server_ami" {
  most_recent = true
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

#resource "aws_key_pair" "KeypairAuth" {
#  key_name   = "${var.key_name}"
#  public_key = "${file(var.public_key_path)}"
#}

data "template_file" "user-init" {
  count    = 2
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    firewall_subnets = "${element(var.all_subnet_ids, count.index)}"
  }
}

resource "aws_instance" "myInstance" {

  count         = 2
  instance_type = "t2.micro"
  ami           = "${data.aws_ami.server_ami.id}"
#  key_name               = "${aws_key_pair.KeypairAuth.id}"
  vpc_security_group_ids = ["${var.SecurityGroupName}"]
  subnet_id              = "${var.all_subnet_ids[count.index]}"
  user_data              = "${data.template_file.user-init.*.rendered[count.index]}"
  
  tags {
    Name = "myInstance-${count.index +1}_${var.env}"
  }
}
