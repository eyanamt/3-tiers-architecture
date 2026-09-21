############################################################
# NIVEAU APPLICATIF (ex 04-app-tier.yaml)
############################################################

resource "aws_lb" "app" {
  name               = "${var.environment_name}-app-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_alb.id]
  subnets            = [aws_subnet.app_1.id, aws_subnet.app_2.id]
}

resource "aws_lb_target_group" "app" {
  name        = "${var.environment_name}-app-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    path = "/health"
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_launch_template" "app" {
  name          = "${var.environment_name}-app-lt"
  image_id      = data.aws_ssm_parameter.al2023_ami.value
  instance_type = var.app_instance_type

  vpc_security_group_ids = [aws_security_group.app_tier.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo "Niveau applicatif - ${var.environment_name}" > /tmp/app-init.log
  EOF
  )
}

resource "aws_autoscaling_group" "app" {
  name                = "${var.environment_name}-app-asg"
  vpc_zone_identifier = [aws_subnet.app_1.id, aws_subnet.app_2.id]
  min_size            = var.app_min_size
  max_size            = var.app_max_size
  desired_capacity    = var.app_desired_capacity
  target_group_arns   = [aws_lb_target_group.app.arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = aws_launch_template.app.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.environment_name}-app-instance"
    propagate_at_launch = true
  }
}
