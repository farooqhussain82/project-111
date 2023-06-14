

variable "domain" {
  default     = "datahub"
  description = "Domain name for open search."
}

variable "open_search_instance_type" {
  default     = "m5.large.search"
  type        = string
  description = "Instance type for AWS OpenSearch service"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "region" {
  default     = "ap-southeast-1"
  type        = string
  description = "AWS Region"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
}

variable "app_private_subnets" {
  type        = list(any)
  description = "App Private Subnet IDs"
}
