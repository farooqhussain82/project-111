variable "cluster_name" {
    default = "datahubmskcluster"
    type = string  
}

variable "kafka_version" {
    default = "2.8.1"
    type = string
}

variable "instance_class" {
    default = "kafka.m5.large"
    type = string
}

variable "number_of_broker_nodes" {
    default = 3
    type = number
}

variable "kafka_broker_storage_volume" {
    default = 1000
    type = number
}

variable "private_subnets" {
    type = list(any)
}

variable "msk_security_group" {
    type = list(any)
}