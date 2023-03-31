
resource "aws_vpc" "my-vpc2" {
  cidr_block = "200.200.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc2"
  }
}

resource "aws_subnet" "my-vpc2-subnet1" {
  vpc_id = aws_vpc.my-vpc2.id
  cidr_block = "200.200.10.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-vpc2-subnet1"
  }
}

resource "aws_subnet" "my-vpc2-subnet2" {
  vpc_id = aws_vpc.my-vpc2.id
  cidr_block = "200.200.20.0/24"
  availability_zone = "ap-northeast-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-vpc2-subnet2"
  }
}

resource "aws_subnet" "my-vpc2-subnet3" {
  vpc_id = aws_vpc.my-vpc2.id
  cidr_block = "200.200.30.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-vpc2-subnet3"
  }
}

resource "aws_subnet" "my-vpc2-subnet4" {
  vpc_id = aws_vpc.my-vpc2.id
  cidr_block = "200.200.40.0/24"
  availability_zone = "ap-northeast-2d"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-vpc2-subnet4"
  }
}

resource "aws_internet_gateway" "my-igw2" {
  vpc_id = aws_vpc.my-vpc2.id
}

resource "aws_default_route_table" "my-vpc2-route-table" {
  default_route_table_id = aws_vpc.my-vpc2.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw2.id
  }
}

resource "aws_security_group" "my_front_sg" {
  vpc_id = aws_vpc.my-vpc2.id
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my_back_sg" {
  vpc_id = aws_vpc.my-vpc2.id
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "gunicorn"
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "my_db_sg" {
  vpc_id = aws_vpc.my-vpc2.id
  ingress {
    description = "mysql"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "my_front_sg_id" {
  value = aws_security_group.my_front_sg.id
}

output "my_back_sg_id" {
  value = aws_security_group.my_back_sg.id
}

output "my-vpc2-subnet1_id" {
  value = aws_subnet.my-vpc2-subnet1.id
}

output "my-vpc2-subnet2_id" {
  value = aws_subnet.my-vpc2-subnet2.id
}

output "my_db_sg_id" {
  value = aws_security_group.my_db_sg.id
}
