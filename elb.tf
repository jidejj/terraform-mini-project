resource "aws_lb" "inst-load-balancer" {
  name = "inst-load-balancer"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.inst-load_balancer_sg.id]
  subnets = [aws_subnet.inst-public-subnet1.id, aws_subnet.inst-public-subnet2.id]
  enable_deletion_protection = false
  depends_on = [ aws_instance.inst-1, aws_instance.inst-2, aws_instance.inst-3 ]
}

resource "aws_lb_target_group" "inst-target-group" {
  name = "inst-target-group"
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.inst_vpc.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
}


resource "aws_lb_listener" "inst-listener" {
  load_balancer_arn = aws_lb.inst-load-balancer.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.inst-target-group.arn
  }
}

resource "aws_lb_listener_rule" "inst-listener-rule" {
    listener_arn = aws_lb_listener.inst-listener.arn
    priority = 1

    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.inst-target-group.arn
    }

    condition {
      path_pattern {
        values = ["/"]
      }
    }
}

resource "aws_lb_target_group_attachment" "inst-target-group-attachement1" {
  target_group_arn = aws_lb_target_group.inst-target-group.arn
  target_id = aws_instance.inst-1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "inst-target-group-attachement2" {
  target_group_arn = aws_lb_target_group.inst-target-group.arn
  target_id = aws_instance.inst-2.id
  port = 80
}

resource "aws_lb_target_group_attachment" "inst-target-group-attachement3" {
  target_group_arn = aws_lb_target_group.inst-target-group.arn
  target_id = aws_instance.inst-3.id
  port = 80
}
