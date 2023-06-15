output "open_search_instance_domain_id" {
  value       = aws_opensearch_domain.datahub_open_search_instance.domain_id
  description = "OpenSearch Domain ID"
  sensitive   = false
}

output "open_search_instance_domain_name" {
  value       = aws_opensearch_domain.datahub_open_search_instance.domain_name
  description = "OpenSearch Domain Name"
  sensitive   = false
}

# output "open_search_master_username" {
#   value       = aws_opensearch_domain.datahub_open_search_instance.advanced_security_options.master_user_options.master_user_name
#   description = "OpenSearch Master UserName."
#   sensitive   = false
# }

output "open_search_master_user_password" {
  value       = random_password.open_search_master_user_password.result
  description = "OpenSearch Master User Password"
  sensitive   = true
}
