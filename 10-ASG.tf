resource "aws_autoscaling_group" "cf_asg" {
  name_prefix      = "${var.name_prefix}-coalfire-asg"
  min_size         = 2
  max_size         = 6
  desired_capacity = 2
  vpc_zone_identifier = [
    aws_subnet.subnet3.id,
    aws_subnet.subnet4.id
  ]
  health_check_type         = "ELB"
  health_check_grace_period = 300
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.cf_tg.arn]


  launch_template {
    id      = aws_launch_template.apache-web.id
    version = "$Latest"
  }

  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]


  tag {
    key                 = "Name"
    value               = "apache-web"
    propagate_at_launch = true
  }
}

# Auto Scaling Policy
resource "aws_autoscaling_policy" "cf_scaling_policy" {
  name                   = "coalfire-autoscaling-policy"
  autoscaling_group_name = aws_autoscaling_group.cf_asg.name

  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 120

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
  }
}

# Enabling instance scale-in protection
resource "aws_autoscaling_attachment" "cf_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.cf_asg.name
  lb_target_group_arn    = aws_lb_target_group.cf_tg.arn
}