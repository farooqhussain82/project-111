resource "aws_msk_cluster" "datahub_msk" {
    cluster_name = var.cluster_name
    kafka_version = var.kafka_version
    number_of_broker_nodes = var.number_of_broker_nodes

    brobroker_node_group_info {
        instance_types = var.instance_class
        client_subnets = var.private_subnets
    }
    storage_info {
        ebs_storage_info {
            volume_size = var.kafka_broker_storage_volume
        }
    }
    security_groups = var.vpc_security_group_ids
}

output "zookeeper_connect_string" {
    value = aws_msk_cluster.datahub_msk.zookeeper_connect_string
}

output "bootstrap_brokers_tls" {
    description = "TLS connection host:port pairs"
    value = aws_msk_cluster.datahub_msk.bootstrap_brokers_tls
}