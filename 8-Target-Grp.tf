resource "aws_lb_target_group" "cf_tg" {
  name        = "cf-443-target-group"
  port        = 80     #changed from 443
  protocol    = "HTTP" #changed from HTTPS
  vpc_id      = aws_vpc.poc-vpc-cf.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    protocol            = "HTTP" #changed from HTTPS
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    matcher             = "300"
  }

  tags = {
    Name    = "CF-443-targetGroup"
    Service = "CF-Proof-of-concept-VPC"
    Project = "SGS as a Service"
    Owner   = "SGS"
  }
}
