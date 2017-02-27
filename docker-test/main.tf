provider "aws" {
  region = "us-east-1"
}



resource "aws_instance" "example" {
  ami           = "ami-0b33d91d"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  key_name = "karasys-key"
  user_data = "${file("./setup.sh")}"
  tags {
    Name = "docker-test"
  }
}

resource "aws_security_group" "instance" {
  name = "docker-test-sg"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
