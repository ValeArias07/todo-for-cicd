resource "aws_ecs_task_definition" "front-task" {
  for_each                 = var.task_list
  family                   = each.value.name
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${each.value.name}",
      "image": "${each.value.image_uri}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${each.value.container_port},
          "hostPort": ${each.value.container_port}
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = [var.type_of_nodes] # use Fargate as the launch type
  network_mode             = "awsvpc"            # add the AWS VPN network mode as this is required for Fargate
  memory                   = 512                 # Specify the memory the container requires
  cpu                      = 256                 # Specify the CPU the container requires
  execution_role_arn       = var.aws_iam_role
}

resource "aws_ecs_service" "service" {
  for_each        = var.task_list
  name            = each.value.name                                             # Name the service
  cluster         = var.cluster_id                              # Reference the created Cluster
  task_definition = aws_ecs_task_definition.front-task[each.key].arn # Reference the task that the service will spin up
  launch_type     = var.type_of_nodes
  desired_count   = 1 # Set up the number of containers to 3

  load_balancer {
    target_group_arn = var.aws_lb_target_group_arn[each.key] # Reference the target group
    container_name   = each.value.name
    container_port   = each.value.container_port # Specify the container port
  }

  network_configuration {
    subnets          = ["${var.subnet_a_id}", "${var.subnet_a_id}"]
    assign_public_ip = true                                                          # Provide the containers with public IPs
    security_groups  = ["${aws_security_group.service_security_group[each.key].id}"] # Set up the security group
  }
}

resource "aws_security_group" "service_security_group" {
  for_each = var.task_list
  ingress {
    from_port = each.value.container_port
    to_port   = each.value.container_port
    protocol  = "tcp"
    # Only allowing traffic in from the load balancer security group
    security_groups = ["${var.aws_security_group_id[each.key]}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


