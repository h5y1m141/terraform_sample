resource "aws_instance" "dev-server1" {
  ami = "ami-da9e2cbc"
  instance_type = "t2.micro"
  subnet_id = "${var.private_subnet_id}"
  monitoring = false
  tags {
    Name = "dev-server1"
  }
}
