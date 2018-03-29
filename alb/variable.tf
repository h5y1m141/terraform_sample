variable "alb_name" {
  description = "ALB name ex: main-alb"
}
variable "security_group_web" {
  description = "define which security group belongs to"
}
variable "public_subnet_list" {
  type = "list"
}
variable "vpc_id" {
  description = "select which vpc belongs to"
}
variable "internal_dev_server" {
  description = "target instance"
}
