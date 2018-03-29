resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "dev-server1" {
  ami = "ami-da9e2cbc"
  instance_type = "t2.micro"
  subnet_id = "${var.public_subnet_id}"
  key_name      = "${aws_key_pair.auth.id}"
  monitoring = false
  vpc_security_group_ids = ["${var.security_group_ssh}"]
  tags {
    Name = "dev-server1"
  }
}
resource "aws_instance" "dev-server2" {
  ami = "ami-da9e2cbc"
  instance_type = "t2.micro"
  subnet_id = "${var.private_subnet_id}"
  key_name      = "${aws_key_pair.auth.id}"
  monitoring = false

  tags {
    Name = "dev-server2"
  }
}
output "internal_dev_server" {
  value = "${aws_instance.dev-server2.id}"
}
