access_key     = "{{ secrets.AWS_ACC_KEY }}"
secret_key     = "{{ secrets.AWS_SECRET_KEY }}"
project_region = "us-east-1"
cluster_name   = "todo-cluster"
type_of_nodes  = "FARGATE"
iam_policy_arn = [
  "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
, "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
]
task_list = {
      front_task = {
        name           = "todo-front",
        service        = "todo-service",
        image_uri      = "valeariasp/todo-cicd:df4f788245956d613838be6352058dc38738015",
        container_port = 3000,
        host_port      = 3000,
        tg_port        = 80,
        protocol       = "HTTP",
        desired_count  = 1
      }
}