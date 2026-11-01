provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project     = var.name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

module "vpc" {
  source      = "./modules/vpc"
  name        = var.name
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  az_count    = var.az_count
}

module "iam" {
  source       = "./modules/iam"
  cluster_name = "${var.name}-${var.environment}"
}

module "eks" {
  source                         = "./modules/eks"
  cluster_name                   = "${var.name}-${var.environment}"
  cluster_version                = var.cluster_version
  cluster_role_arn               = module.iam.cluster_role_arn
  node_role_arn                  = module.iam.node_role_arn
  private_subnet_ids             = module.vpc.private_subnet_ids
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  cluster_public_access_cidrs    = var.cluster_public_access_cidrs
  on_demand_instance_types       = var.on_demand_instance_types
  spot_instance_types            = var.spot_instance_types
  on_demand_min_size             = var.on_demand_min_size
  on_demand_max_size             = var.on_demand_max_size
  on_demand_desired_size         = var.on_demand_desired_size
  spot_min_size                  = var.spot_min_size
  spot_max_size                  = var.spot_max_size
  spot_desired_size              = var.spot_desired_size

  depends_on = [module.iam]
}
