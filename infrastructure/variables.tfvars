access_key     = {{ secret.AWS_ACC_KEY }}
secret_key     = {{ secret.AWS_SECRET_KEY }}
project_region = "us-east-1"
cluster_name   = "todo-cluster"
type_of_nodes  = "FARGATE"
iam_policy_arn = [
  "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
, "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
]
"task_list = {
      front_task = {
        name           = \"todo-front\",
        service        = \"todo-service\",
        image_uri      = \"",
        container_port = 3000,
        host_port      = 3000,
        tg_port        = 80,
        protocol       = \"HTTP\",
        desired_count  = 1
      }
}