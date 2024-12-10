output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_alb.alb.dns_name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.default.name
}