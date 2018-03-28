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
module "dev-server" {
  source = "./ec2"
  private_subnet_id = "${module.dev-vpc.private_subnet_id}"
}
