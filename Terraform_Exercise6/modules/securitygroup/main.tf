resource "aws_security_group" "mySecurityGroup" {
  
  description = "Used for access to the public instances"
  vpc_id      = "${var.vpcid_subnet}"

  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
   # cidr_blocks = ["${var.subnet_ips[0]}"]
      cidr_blocks = ["0.0.0.0/0"]
 
 }

  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
   # cidr_blocks = ["${var.subnet_ips[1]}"]
     cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
