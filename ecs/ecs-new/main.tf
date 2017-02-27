provider "aws" {
  region = "${var.region}"
}

//Create clust
resource "aws_ecs_cluster" "main" {
    name = "${var.ecs_cluster_name}"
}

resource "aws_iam_instance_profile" "ecs" {
    name = "ecs-instance-profile"
    path = "/"
    roles = ["${aws_iam_role.ecs_host_role.name}"]
}

//Create a launch_configuration
resource "aws_launch_configuration" "ecs" {
    name = "trp-gc-${var.ecs_cluster_name}"
    image_id = "${lookup(var.amis, var.region)}"
    instance_type = "${var.instance_type}"
    security_groups = ["${aws_security_group.ecs-sg.id}"]
    iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"
    # TODO: is there a good way to make the key configurable sanely?
    key_name = "${var.key_name}"
    associate_public_ip_address = true
    user_data = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}' > /etc/ecs/ecs.config"
}

// Create an
resource "aws_autoscaling_group" "ecs-cluster" {
    availability_zones = ["${var.availability_zone}"]
    name = "trp-asg-gc-${var.ecs_cluster_name}"
    min_size = "${var.autoscale_min}"
    max_size = "${var.autoscale_max}"
    desired_capacity = "${var.autoscale_desired}"
    health_check_type = "EC2"
    launch_configuration = "${aws_launch_configuration.ecs.name}"
    vpc_zone_identifier = ["${var.mysubnet1a}"]
}
