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
  description = "Object structure to create a task"
}

variable "subnet_a_id" {
  type        = string
  description = "Subnet A id"
}

variable "subnet_b_id" {
  type        = string
  description = "Subnet B id"
}

variable "default_vpc_id" {
  type        = string
  description = "Default VPC id"
}