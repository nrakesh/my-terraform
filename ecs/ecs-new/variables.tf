variable "region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "availability_zone" {
    description = "The availability zone"
    default = "us-east-1a"
}

variable "key_name" {
  description = "Name of AWS key pair"
  default = "karasys-key"
}

variable "autoscale_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "autoscale_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "autoscale_desired" {
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

variable "amis" {
    description = "Which AMI to spawn. Defaults to the AWS ECS optimized images."
    # TODO: support other regions.
    default = {
        us-east-1 = "ami-ddc7b6b7"
    }
}

variable "mysubnet1a" {
  default="subnet-37d34c1a"
}
variable "mysubnet1b" {
  default="subnet-3ecad577"
}
//----------
variable "ecs_cluster_name" {
  default="mycluster"
}

variable "instance_type" {
    default = "t2.micro"
}
