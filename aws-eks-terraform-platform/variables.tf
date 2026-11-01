variable "region" {
  description = "AWS region for the cluster and network."
  type        = string
  default     = "ap-south-1"
}

variable "name" {
  description = "Short project name used in resource names and tags."
  type        = string
  default     = "platform"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be dev or prod."
  }
}

variable "vpc_cidr" {
  description = "IPv4 CIDR range for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones for the VPC."
  type        = number
  default     = 3

  validation {
    condition     = var.az_count >= 2 && var.az_count <= 3
    error_message = "az_count must be 2 or 3."
  }
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS control plane."
  type    = string
  default = "1.33"
}

variable "cluster_endpoint_public_access" {
  description = "Whether the Kubernetes API endpoint is reachable from approved public CIDRs."
  type        = bool
  default     = true
}

variable "cluster_public_access_cidrs" {
  description = "Source CIDRs allowed to reach the public Kubernetes API endpoint. Replace the documentation CIDR before deployment."
  type        = list(string)
  default     = ["203.0.113.0/24"]
}

variable "on_demand_instance_types" {
  description = "EC2 instance types for the baseline managed node group."
  type        = list(string)
  default     = ["t3.large"]
}

variable "spot_instance_types" {
  description = "EC2 instance types for interruptible workloads."
  type        = list(string)
  default     = ["t3.large", "t3a.large", "m5.large"]
}

variable "on_demand_min_size" {
  type    = number
  default = 1
}

variable "on_demand_max_size" {
  type    = number
  default = 4
}

variable "on_demand_desired_size" {
  type    = number
  default = 1
}

variable "spot_min_size" {
  type    = number
  default = 0
}

variable "spot_max_size" {
  type    = number
  default = 3
}

variable "spot_desired_size" {
  type    = number
  default = 0
}
