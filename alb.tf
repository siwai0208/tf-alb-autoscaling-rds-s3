
resource "aws_lb" "ApplicationLoadBalancer" {
  name               = "ApplicationLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = [
      aws_subnet.SubnetsPUB1.id,
      aws_subnet.SubnetsPUB2.id,
  ]
  security_groups    = [
    aws_security_group.ALBSecurityGroup.id
  ]
}

resource "aws_lb_target_group" "ALBTargetGroup" {
  name = "ALBTargetGroup"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.VPC.id
  health_check {
    path = "/index.php"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 5
  }
  stickiness {
    enabled = "true"
    type = "lb_cookie"
    cookie_duration = 300
  }
}

resource "aws_lb_listener" "ALBListener" {
  load_balancer_arn = aws_lb.ApplicationLoadBalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ALBTargetGroup.arn
  }
}

output "WebsiteURL" {
  value = aws_lb.ApplicationLoadBalancer.dns_name
}