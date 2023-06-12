variable "cluster_name" {
    default = "datahub_msk_cluster"
    type = string  
}

variable "kafka_version" {
    default = "2.8.1"
    type = string
}

variable "instance_class" {
    default = "kafka.m5.large"
}

variable "number_of_broker_nodes" {
    type = number
}

variable "kafka_broker_storage_volume" {
    type = number
}