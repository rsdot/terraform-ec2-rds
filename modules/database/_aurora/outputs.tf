output "aurora_cluster" {
  value = {
    endpoint = aws_rds_cluster.aurora_cluster.endpoint
    id = aws_rds_cluster.aurora_cluster.id
  }
}

output "aurora_instance_writer" {
  value = {
    endpoint =  aws_rds_cluster_instance.aurora_instance_writer.endpoint
    id = aws_rds_cluster_instance.aurora_instance_writer.id
  }
}

output "aurora_instance_replicas" {
  value = {
    endpoint =  aws_rds_cluster_instance.aurora_instance_replicas[*].endpoint
    id = aws_rds_cluster_instance.aurora_instance_replicas[*].id
  }
}

output "engine_version" {
  value = var.engine_version
}

