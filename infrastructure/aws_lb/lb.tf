resource "aws_alb" "application_load_balancer" {
  name               = "dendrogram-alb-dev"
  load_balancer_type = "application"
  subnets = [
    "${var.subnet_a_id}",
    "${var.subnet_b_id}"
  ]
  security_groups = [aws_security_group.load_balancer_security_group["front_task"].id,
  aws_security_group.load_balancer_security_group["back_task"].id]
}

resource "aws_security_group" "load_balancer_security_group" {
  for_each = var.task_list
  ingress {
    from_port   = each.value.tg_port
    to_port     = each.value.tg_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "target_group" {
  for_each    = var.task_list
  name        = "target-group-${each.value.name}"
  port        = each.value.tg_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.default_vpc_id
}

resource "aws_lb_listener" "listener" {
  for_each          = var.task_list
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = each.value.tg_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[each.key].arn
  }
}