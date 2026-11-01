resource "aws_kms_key" "secrets" {
  description             = "EKS secret encryption for ${var.cluster_name}"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "cluster" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 30
}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.cluster_version

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_public_access_cidrs
  }

  encryption_config {
    provider {
      key_arn = aws_kms_key.secrets.arn
    }
    resources = ["secrets"]
  }

  depends_on = [aws_cloudwatch_log_group.cluster]
}

resource "aws_eks_node_group" "on_demand" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "on-demand"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = var.on_demand_instance_types
  capacity_type   = "ON_DEMAND"

  scaling_config {
    min_size     = var.on_demand_min_size
    max_size     = var.on_demand_max_size
    desired_size = var.on_demand_desired_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [aws_eks_cluster.this]
}

resource "aws_eks_node_group" "spot" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "spot"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = var.spot_instance_types
  capacity_type   = "SPOT"
  labels          = { workload = "non-critical" }

  scaling_config {
    min_size     = var.spot_min_size
    max_size     = var.spot_max_size
    desired_size = var.spot_desired_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [aws_eks_cluster.this]
}