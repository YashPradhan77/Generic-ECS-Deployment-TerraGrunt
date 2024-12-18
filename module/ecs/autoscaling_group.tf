# Creates an ASG linked with our main VPC

resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  count                 = var.launch_type == "EC2" ? 1 : 0
  name                  = "${var.namespace}_ASG_${var.environment}"
  max_size              = var.ec2_autoscaling_max_size
  min_size              = var.ec2_autoscaling_min_size
  desired_capacity      = var.ec2_desired_capacity
  vpc_zone_identifier   = var.public_subnet_ids
  health_check_type     = "EC2"
  protect_from_scale_in = false

  health_check_grace_period = 120
  default_cooldown          = 120

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  launch_template {
    id      = aws_launch_template.ecs_launch_template[0].id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.namespace}_ASG_${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    propagate_at_launch = false
    value               = var.environment
  }
}
