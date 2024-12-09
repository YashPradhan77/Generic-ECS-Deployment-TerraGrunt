# Fargate

resource "aws_ecs_task_definition" "fargate_default" {
  for_each = var.containers
  family   = "${each.key}_Tdf_${var.environment}"

  network_mode = var.launch_type == "FARGATE" ? "awsvpc" : "bridge"

  requires_compatibilities = ["${var.launch_type}"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = var.launch_type == "EC2" ? aws_iam_role.ecs_task_iam_role.arn : null

  cpu    = var.launch_type == "FARGATE" ? tonumber(each.value.cpu_units) : null
  memory = var.launch_type == "FARGATE" ? tonumber(each.value.memory) : null

  container_definitions = jsonencode([
    {
      name      = each.key
      image     = each.value.image_uri
      cpu       = tonumber(each.value.cpu_units) # Ensure integer
      memory    = tonumber(each.value.memory)    # Ensure integer
      essential = true
      environment = concat(
        [
          {
            name  = "ENVS"
            value = "test_env_val"
          }
        ],
        each.value.envs
      )
      secrets = concat(
        [
          {
            name      = "ENV_CONFIG"
            valueFrom = aws_secretsmanager_secret.config_secret[each.key].arn
          }
        ],
        each.value.secrets
      )
      portMappings = [
        {
          containerPort = tonumber(each.value.container_port) # Ensure integer
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group["${each.key}"].name
          "awslogs-region"        = data.aws_region.current.name
          "awslogs-stream-prefix" = "${each.key}-log-stream-${var.environment}"
        }
      }

    }
  ])
}

# resource "aws_vpc_endpoint" "secrets_manager" {
#   vpc_id       = var.vpc_id
#   service_name = "com.amazonaws.${data.aws_region.current.name}.secretsmanager"
#   vpc_endpoint_type = "Interface"
#   subnet_ids   = var.private_subnet_ids
#   security_group_ids = [aws_security_group.allow_secrets_access.id]
# }

# resource "aws_security_group" "allow_secrets_access" {
#   vpc_id = var.vpc_id

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # Or restrict to internal IP ranges
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

