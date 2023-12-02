output "lb_url" {
  value = aws_alb.application_load_balancer.dns_name
}

output "aws_security_group_id" {
  value = {
    for k, v in aws_security_group.load_balancer_security_group: k => v.id
  }
}

output "aws_lb_target_group_arn" {
  value = {
    for k, v in aws_lb_target_group.target_group: k => v.arn
  }
}
