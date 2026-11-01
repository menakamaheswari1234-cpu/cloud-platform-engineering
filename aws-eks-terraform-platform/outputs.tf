output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}
