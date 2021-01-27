variable "SSHLocation" {
  type        = string
}
variable "HTTPLocation" {
  type        = string
}

resource "aws_security_group" "ALBSecurityGroup" {
    name ="ALBSecurityGroup"
    vpc_id= aws_vpc.VPC.id
    ingress{
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks =[var.HTTPLocation]
    }
    egress{
       from_port  = 0
       to_port    = 0
       protocol   = "-1"
       cidr_blocks=["0.0.0.0/0"]
   }
}

resource "aws_security_group" "ASSecurityGroup" {
    name = "ASSecurityGroup"
    description = "Enable SSH and HTTP"
    vpc_id = aws_vpc.VPC.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.SSHLocation]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
         security_groups =[aws_security_group.ALBSecurityGroup.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}