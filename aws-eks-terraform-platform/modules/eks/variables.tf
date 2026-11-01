variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "cluster_endpoint_public_access" {
  type = bool
}

variable "cluster_public_access_cidrs" {
  type = list(string)
}

variable "on_demand_instance_types" {
  type = list(string)
}

variable "spot_instance_types" {
  type = list(string)
}

variable "on_demand_min_size" {
  type = number
}

variable "on_demand_max_size" {
  type = number
}

variable "on_demand_desired_size" {
  type = number
}

variable "spot_min_size" {
  type = number
}

variable "spot_max_size" {
  type = number
}

variable "spot_desired_size" {
  type = number
}