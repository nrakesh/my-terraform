provider "aws" {
  region = "us-east-1"
  profile = "shared-sb"
}


data "aws_ami" "rhel" {
  most_recent = true
  filter {
    name = "name"
    values = ["TRP-RHEL7-CIS-unEncrypted*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["383856603817"] # Canonical
}

data "aws_security_group" "selected" {
  filter {
    name = "tag:Name"
    values = ["trp-default"]
  }
}

data "aws_subnet" "PublicAZA" {
  filter {
    name = "tag:Name"
    values = ["*priv*"]
  }
  filter {
    name = "availability-zone"
    values = ["us-east-1a"]
  }
}

data "aws_subnet" "PublicAZB" {
  filter {
    name = "tag:Name"
    values = ["*priv*"]
  }
  filter {
    name = "availability-zone"
    values = ["us-east-1b"]
  }
}

resource "aws_instance" "sfg-node-1" {
    ami = "${data.aws_ami.rhel.id}"
    instance_type = "t2.micro"
    subnet_id = "${data.aws_subnet.PublicAZA.id}"
    vpc_security_group_ids = ["${data.aws_security_group.selected.id}"]
    tags {
        Name = "sfg-node-1"
    }
}

resource "aws_instance" "sfg-node-2" {
    ami = "${data.aws_ami.rhel.id}"
    instance_type = "t2.micro"
    subnet_id = "${data.aws_subnet.PublicAZB.id}"
    vpc_security_group_ids = ["${data.aws_security_group.selected.id}"]
    tags {
        Name = "sfg-node-2"
    }
}
