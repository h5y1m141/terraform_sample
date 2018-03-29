variable "alb_name" {
  description = "ALB name ex: main-alb"
}
variable "security_group_web" {
  description = "define which security group belongs to"
}
variable "public_subnet_list" {
  type = "list"
}
