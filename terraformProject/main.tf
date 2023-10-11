terraform{
    required_providers{
        aws={
            source="hashicorp/aws"
            version="5.17.0"
        }
    }
}

provider "aws" {
region = var.region

}

resource "aws_key_pair" "project3_launchtemplate_key" {
key_name = var.key_name
public_key = var.public_key
}

resource "aws_security_group" "project3-sg1" {
name_prefix = "Project3_SecurityGroup1"
description = "security group created for launch template specified in auto scaling group"
egress = [
{
cidr_blocks = [ "0.0.0.0/0" ]
description = "Opens outbound traffic to all sources"
from_port = 0
ipv6_cidr_blocks = [ ]
prefix_list_ids = [ ]
protocol = "all"
security_groups = [ ]
self = false
to_port = 0
}
]
ingress = [
{

cidr_blocks = [ "0.0.0.0/0" ]
description = "Opens ssh"
from_port = 22
ipv6_cidr_blocks = [ ]
prefix_list_ids = [ ]
protocol = "tcp"
security_groups = [ ]
self = false
to_port = 22
},
{
cidr_blocks = [ "0.0.0.0/0" ]
description = "Opens http"
from_port = 80
ipv6_cidr_blocks = [ ]
prefix_list_ids = [ ]
protocol = "tcp"
security_groups = [ ]
self = false
to_port = 80
}
]
tags = {
"Description" = "Project3 SecurityGroup1 for Ports 22|80"
}
vpc_id = var.default_vpc_id
}

resource "aws_launch_template" "project3_lt1" {
name_prefix = "Project3-LaunchTemplate1"
description = "Launch template for Auto scaling group managed by terraform."
image_id = var.ami_id
instance_type = "t2.micro"
key_name = aws_key_pair.project3_launchtemplate_key.key_name
tags = {
"Name" = "Project3 LaunchTemplate1-TF"
}
user_data = "${filebase64("nginx_data.sh")}"
vpc_security_group_ids = [ aws_security_group.project3-sg1.id ]

}

resource "aws_lb" "project3_lb1" {
internal = false
ip_address_type = "ipv4"
# load_balancer_type = "application"
name_prefix = "tf-lb1"
security_groups = [ aws_security_group.project3-sg1.id ]
subnets = var.default_subnet_ids
tags = {
"Name" = "Load Balancer with Target Group and Listener Configured",
"Description" = "Project 3 terraform created load balancer"
}
}

resource "aws_lb_target_group" "project3_lb1_target_group" {
health_check {
# enabled = true
# interval = 30
matcher = "200"
path = "/"
# port = "traffic-port"
# protocol = "HTTP"
}
name_prefix = "tf-tg1"
port = 80
protocol_version = "HTTP1"
protocol = "HTTP"
tags = {
"Description" = "Project3-LoadBalancer1_TargetGroup-TF"
}
target_type = "instance"
ip_address_type = "ipv4"
vpc_id = var.default_vpc_id
}

resource "aws_lb_listener" "project3_lb1_listener" {
default_action {
type = "forward"
target_group_arn = aws_lb_target_group.project3_lb1_target_group.arn
}
load_balancer_arn = aws_lb.project3_lb1.arn

port = 80
protocol = "HTTP"
tags = {
"Description" = "AWS load balancer listener created using terraform for project 3"
}
}

resource "aws_autoscaling_group" "project3_asg1" {
name_prefix = "Project3AutoScalingGroup"
max_size = 2
min_size = 1
desired_capacity = 1
launch_template {
id = aws_launch_template.project3_lt1.id
version = aws_launch_template.project3_lt1.latest_version
}
health_check_grace_period = 30
health_check_type = "ELB"
vpc_zone_identifier = var.default_subnet_ids
target_group_arns = [ aws_lb_target_group.project3_lb1_target_group.arn ]
}