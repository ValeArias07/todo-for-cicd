variable "type_of_nodes" {
  type        = string
  default     = "FARGATE"
  description = "Type of the machine to deploy the containers"
}

variable "aws_iam_role" {
  type        = string
  description = "Role to execute the task"
}

variable "cluster_id" {
  type        = string
  description = "Id of the cluster"
}

variable "task_list" {
  type = map(object({
    name           = string,
    service        = string,
    image_uri      = string,
    container_port = number,
    host_port      = number
    tg_port        = number,
    protocol       = string,
    desired_count  = number,
  }))
  description = "Structure to create a task"
}

variable "subnet_a_id" {
  type        = string
  description = "Subnet A id"
}

variable "subnet_b_id" {
  type        = string
  description = "Subnet B id"
}

variable "aws_lb_target_group_arn"{
  type        = map(string)
  description = "Load balancer target group for each task"
}

variable "aws_security_group_id"{
  type        = map(string)
  description = "Load balancer security group for each task"
}
