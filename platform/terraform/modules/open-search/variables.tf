variable "vpc" {}

variable "domain" {
  default     = "tf-test"
  description = "Domain name for open search."
}

variable "vpc_subnets_name" {
  default     = ""
  type        = list()
  description = "List of subnets name associated vpc for open search"
}
