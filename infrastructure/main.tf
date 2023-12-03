# reuirements.tf
terraform {
  backend "s3" {
    bucket = "todo-ops-tf"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.45.0"
    }
  }
}

provider "aws" {
  region     = var.project_region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
    source = "./aws_vpc"
}

module "lb" {
    source = "./aws_lb"
    task_list = var.task_list
    subnet_a_id = module.vpc.subnet_a_id
    subnet_b_id = module.vpc.subnet_b_id
    default_vpc_id = module.vpc.default_vpc_id
}

output "lb_address" {
  value = module.lb.lb_url
}

module "cluster" {
    source = "./aws_ecs_cluster"
    cluster_name = var.cluster_name
}

module "task_definition" {
    source = "./aws_task_definitions"
    aws_iam_role = module.iam.aws_iam_role
    task_list = var.task_list
    type_of_nodes = var.type_of_nodes
    cluster_id = module.cluster.cluster_id
    subnet_a_id = module.vpc.subnet_a_id
    subnet_b_id = module.vpc.subnet_b_id
    aws_lb_target_group_arn = module.lb.aws_lb_target_group_arn
    aws_security_group_id = module.lb.aws_security_group_id
}

module "iam" {
    source = "./aws_iam"
    iam_policy_arn = var.iam_policy_arn
}
