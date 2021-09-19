############################################
# Create web tier auto scaling group
############################################
resource "aws_autoscaling_group" "web_asg" {
  name                = "web-asg"
  max_size            = 2
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.demo_public_subnet_1.id, aws_subnet.demo_public_subnet_2.id]

  launch_template {
    id      = aws_launch_template.web_tier_lt.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

}

resource "aws_autoscaling_attachment" "web_asg_attachment" {
  alb_target_group_arn   = aws_alb_target_group.web_target_group.arn
  autoscaling_group_name = aws_autoscaling_group.web_asg.id
}

############################################
# Create app tier auto scaling group
############################################
resource "aws_autoscaling_group" "app_asg" {
  name                = "app-asg"
  max_size            = 2
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.demo_private_subnet_1.id, aws_subnet.demo_private_subnet_2.id]

  launch_template {
    id      = aws_launch_template.app_tier_lt.id
    version = "$Latest"
  }

}

resource "aws_autoscaling_attachment" "app_asg_attachment" {
  alb_target_group_arn   = aws_alb_target_group.app_target_group.arn
  autoscaling_group_name = aws_autoscaling_group.app_asg.id
}