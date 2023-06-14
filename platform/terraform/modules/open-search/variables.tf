

variable "domain" {
  default     = "datahub"
  description = "Domain name for open search."
}

variable "open_search_instance_type" {
  default     = "m5.large.search"
  type        = string
  description = "Instance type for AWS OpenSearch service"
}

varible "vpc_id" {
  type = string
  description = "VPC ID"
}

varible "region" {
  default = "ap-southeast-1"
  type = string
  description = "AWS Region"
}

varible "vpc_cidr" {
  type = string
  description = "VPC CIDR Block"
}

varible "app_private_subnets" {
  type = string
  description = "App Private Subnet"
}
