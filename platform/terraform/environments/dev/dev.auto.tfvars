environment         = "dev"
cidr                = "10.101.0.0/16"
region              = "ap-southeast-1"
database_subnets    = ["10.101.1.0/24", "10.101.2.0/24", "10.101.3.0/24"]
private_subnets     = ["10.101.11.0/24", "10.101.12.0/24", "10.101.13.0/24"]
public_subnets      = ["10.101.21.0/24", "10.101.22.0/24", "10.101.23.0/24"]
intra_subnets       = ["10.101.31.0/24", "10.101.32.0/24", "10.101.33.0/24"]
elasticache_subnets = ["10.101.41.0/24", "10.101.42.0/24", "10.101.43.0/24"]

public_network_inbound_acl_rules = [
  { rule_number = "100", rule_action = "deny", from_port = "0", to_port = "0", protocol = "-1", cidr_block = "0.0.0.0/0" }
]

public_network_outbound_acl_rules = [
  { rule_number = "100", rule_action = "deny", from_port = "0", to_port = "0", protocol = "-1", cidr_block = "0.0.0.0/0" }
]

default_network_inbound_acl_rules = [
  { rule_number = "100", rule_action = "deny", from_port = "0", to_port = "0", protocol = "-1", cidr_block = "0.0.0.0/0" }
]

default_network_outbound_acl_rules = [
  { rule_number = "100", rule_action = "deny", from_port = "0", to_port = "0", protocol = "-1", cidr_block = "0.0.0.0/0" }
]

#Kubernetes Variables

max_size       = 3
min_size       = 3
desired_size   = 3
instance_types = ["t3a.micro"]
