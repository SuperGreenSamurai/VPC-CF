resource "aws_lb" "app_lb" {
  name               = "${var.name_prefix}app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  enable_deletion_protection = false

  tags = {
    Name = "app-lb"
  }
}

#Load balancer is listering on port 80, and forwarding traffic to the target group
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cf_tg.arn
  }
}
# Enabling instance scale-in protection

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.cf_asg.name
  lb_target_group_arn    = aws_lb_target_group.cf_tg.arn

}