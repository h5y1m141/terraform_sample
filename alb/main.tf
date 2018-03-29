resource "aws_alb" "alb" {
  name = "${var.alb_name}"
  security_groups = ["${var.security_group_web}"]
  subnets = ["${var.public_subnet_id}","${var.public_subnet_id1}"]
}
