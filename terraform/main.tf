provider "aws" {
  region  = "ap-northeast-2"
}

module "module_ec2" {
  source = "./ec2"
  my_server_ami = "ami-0342738dbfee29539"
  my_server_type = "t2.micro"
}


module "module_rds" {
  source = "./rds"
}


