variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable "key_name" {
  description = "Name of AWS key pair"
  default = "karasys-key"
}

variable "instance_type" {
  default     = "t2.small"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}

variable "admin_cidr_ingress" {
  description = "CIDR to allow tcp/22 ingress to EC2 instance"
  default = "0.0.0.0/0"
}

variable "vpc" {
  default = "vpc-133de375"
}

variable "ecs-ami" {
  default="ami-b2df2ca4"
}

variable "mysubnet1a" {
  default="subnet-37d34c1a"
}
variable "mysubnet1b" {
  default="subnet-3ecad577"
}
