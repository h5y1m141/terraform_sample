provider "aws" {
  profile = "private-aws"
  region = "ap-northeast-1"
}
module "dev-vpc" {
  source = "./vpc"
  vpc_name = "dev-vpc"
  vpc_cidr_block = "10.0.0.0/16"
  public_subnet_cidr_blocks = ["10.0.0.0/24", "10.0.1.0/24"]
  public_subnet_availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
  private_subnet_cidr_blocks = ["10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
}
module "sg" {
  source = "./sg"
  vpc_id = "${module.dev-vpc.vpc_id}"
}
module "dev-server" {
  source = "./ec2"
  public_subnet_id = "${module.dev-vpc.public_subnet_id}"
  private_subnet_id = "${module.dev-vpc.private_subnet_id}"
  key_name = "dev-server-key"
  public_key_path = "~/.ssh/id_rsa.pub"
  security_group_ssh = "${module.sg.security_group_ssh}"
}
module "dev-alb" {
  source = "./alb"
  alb_name = "dev-alb"
  security_group_web = "${module.sg.security_group_web}"
  public_subnet_id = "${module.dev-vpc.public_subnet_id}"
  public_subnet_id1 = "${module.dev-vpc.public_subnet_id1}"
}
