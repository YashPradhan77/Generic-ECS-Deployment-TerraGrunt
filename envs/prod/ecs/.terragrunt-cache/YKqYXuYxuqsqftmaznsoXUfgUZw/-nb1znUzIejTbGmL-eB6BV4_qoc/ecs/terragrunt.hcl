terraform {
  source = "../../../module//ecs"
}


include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  # ECS settings
  instance_type                               = ""        # Set empty if launch_type = "FARGATE"
  launch_type                                 = "FARGATE" # or "FARGATE"
  vpc_id                                      = dependency.vpc.outputs.vpc_id
  public_subnet_ids                           = dependency.vpc.outputs.public_subnets
  private_subnet_ids                          = dependency.vpc.outputs.private_subnets
  containers                                  = yamldecode(file("variables.yml"))["app_deployment"]["containers"]
  ecs_task_deployment_minimum_healthy_percent = 100
  ecs_task_deployment_maximum_percent         = 200
  maximum_scaling_step_size                   = 10
  minimum_scaling_step_size                   = 1
  asg_ec2_target_capacity                     = 100
  cw_logs_retention_in_days                   = 7
  ec2_autoscaling_max_size                    = 6
  ec2_autoscaling_min_size                    = 1
  ec2_desired_capacity                        = 1
  aws_acm_certificate_arn                     = "arn:aws:acm:ap-southeast-1:711387124065:certificate/50a1d91f-b79c-4565-8e4f-fd6e0cc8e7b2"
  enable_cross_zone_load_balancing            = true
}