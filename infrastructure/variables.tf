variable "access_key" {
  type        = string
  description = "Contains the value of the access key"
}

variable "secret_key" {
  type        = string
  description = "Contains the value of the secret key"
}

variable "project_region" {
  type        = string
  description = "Contains the region where the code will be deployed"
}

variable "cluster_name" {
  type        = string
  description = "Contains the name of the ECS cluster"
}

variable "type_of_nodes" {
  type        = string
  default     = "FARGATE"
  description = "Type of the machine to deploy the Containers"
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

variable "iam_policy_arn" {
  type        = set(string)
  description = "IAM Policy to be attached to role"
}