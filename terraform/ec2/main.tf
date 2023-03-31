module "module_vpc" {
  source = "../vpc"
}

resource "aws_instance" "my_front" {
  ami           = var.my_server_ami
  instance_type = var.my_server_type

  vpc_security_group_ids = [ "${module.module_vpc.my_front_sg_id}" ]
  subnet_id = "${module.module_vpc.my-vpc2-subnet1_id}"
  key_name = "kjs"
  tags = {
    group = "front"
  }
}

resource "aws_instance" "my_back" {
  ami           = var.my_server_ami
  instance_type = var.my_server_type

  vpc_security_group_ids = [ "${module.module_vpc.my_back_sg_id}" ]
  subnet_id = "${module.module_vpc.my-vpc2-subnet1_id}"
  key_name = "kjs"
  tags = {
    group = "back"
  }
}
