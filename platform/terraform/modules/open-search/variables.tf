variable "vpc_name" {}

variable "aws_region" {
  default     = "ap-southeast-1"
  description = "Domain name for open search."
}

variable "domain" {
  default     = "datahub"
  description = "Domain name for open search."
}

variable "vpc_subnets_name" {
  default     = []
  type        = list(any)
  description = "List of subnets name associated vpc for open search"
}

variable "open_search_instance_type" {
  default     = "m5.large.search"
  type        = string
  description = "Instance type for AWS OpenSearch service"
}
