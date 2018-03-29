resource "aws_alb" "alb" {
  name = "${var.alb_name}"
  security_groups = ["${var.security_group_web}"]
  subnets = ["${var.public_subnet_list}"]
}
resource "aws_alb_target_group" "alb" {
  count    = 2
  name     = "${var.alb_name}-tg${count.index+1}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  health_check {
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}
resource "aws_alb_listener" "alb" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = "${aws_alb_target_group.alb.0.arn}"
    type             = "forward"
  }
}
resource "aws_alb_target_group_attachment" "alb" {
  count            = 2
  target_group_arn = "${element(aws_alb_target_group.alb.*.arn, count.index)}"
  target_id        = "${var.internal_dev_server}"
  port             = 80
}
