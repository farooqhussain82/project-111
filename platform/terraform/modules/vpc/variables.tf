variable "environment" {
  default = "dev"
  type    = string
}

variable "cidr" {
  type    = string
  default = ""
}

variable "database_subnets" {
  type = list(any)
}

variable "private_subnets" {
  type = list(any)
}

variable "public_subnets" {
  type = list(any)
}

variable "intra_subnets" {
  type = list(any)
}

variable "elasticache_subnets" {
  type = list(any)
}

variable "region" {
  type = string
}

variable "public_network_inbound_acl_rules" {
  description = "public subnet network acl"
  type = list(object({
    rule_number = string
    rule_action = string
    from_port   = string
    to_port     = string
    protocol    = string
    cidr_block  = string
  }))
}

variable "public_network_outbound_acl_rules" {
  description = "public subnet network acl"
  type = list(object({
    rule_number = string
    rule_action = string
    from_port   = string
    to_port     = string
    protocol    = string
    cidr_block  = string
  }))
}

variable "default_network_inbound_acl_rules" {
  description = "public subnet network acl"
  type = list(object({
    rule_number = string
    rule_action = string
    from_port   = string
    to_port     = string
    protocol    = string
    cidr_block  = string
  }))
}

variable "default_network_outbound_acl_rules" {
  description = "public subnet network acl"
  type = list(object({
    rule_number = string
    rule_action = string
    from_port   = string
    to_port     = string
    protocol    = string
    cidr_block  = string
  }))
}
