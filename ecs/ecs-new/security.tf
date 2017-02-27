resource "aws_iam_role" "ecs_host_role" {
    name = "trp-gc-${var.ecs_cluster_name}-ecs-host-role"
    assume_role_policy = "${file("policies/ecs-role.json")}"
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
    name = "trp-gc-${var.ecs_cluster_name}-ecs-instance-role-policy"
    policy = "${file("policies/ecs-instance-role-policy.json")}"
    role = "${aws_iam_role.ecs_host_role.id}"
}

resource "aws_iam_role" "ecs_service_role" {
    name = "trp-gc-${var.ecs_cluster_name}-ecs-service-role"
    assume_role_policy = "${file("policies/ecs-role.json")}"
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
    name = "trp-gc-${var.ecs_cluster_name}-ecs-service-role-policy"
    policy = "${file("policies/ecs-service-role-policy.json")}"
    role = "${aws_iam_role.ecs_service_role.id}"
}

resource "aws_security_group" "load_balancers-sg" {
    name = "trp-gc-${var.ecs_cluster_name}-elb-sg"
    description = "Allows all traffic"
    vpc_id = "${var.vpc}"

    # TODO: do we need to allow ingress besides TCP 80 and 443?
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # TODO: this probably only needs egress to the ECS security group.
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
//create ecs server group
// ** ADDED other security groups to this group ... need to see how this looks
resource "aws_security_group" "ecs-sg" {
    name = "trp-gc-${var.ecs_cluster_name}-instance-sg"
    description = "Allows all traffic"
    vpc_id = "${var.vpc}"

    # TODO: remove this and replace with a bastion host for SSHing into
    # individual machines.
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        security_groups = ["${aws_security_group.load_balancers-sg.id}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
