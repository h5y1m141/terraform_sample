resource "aws_vpc" "mainvpc" {
  cidr_block = "${var.default_cidr_block}"
}
resource "aws_default_security_group" "default" {
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name = "ssh"
  vpc_id = "${var.vpc_id}"
  description = "Allow only ssh"
  ingress {
    from_port = 22
    to_port = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol    = -1
    security_groups = ["${aws_security_group.web.id}"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name = "only_ssh"
  }
}
resource "aws_security_group" "web" {
  name = "sg_web"
  vpc_id = "${var.vpc_id}"
  description = "Allow traffic for Web access"
  ingress {
    from_port = 80
    to_port = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.default_cidr_block}"]
  }
  tags {
    Name = "web_server"
  }
}
output "security_group_ssh" {
  value = "${aws_security_group.ssh.id}"
}
output "security_group_web" {
  value = "${aws_security_group.web.id}"
}
