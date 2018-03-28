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
output "security_group_ssh" {
  value = "${aws_security_group.ssh.id}"
}
