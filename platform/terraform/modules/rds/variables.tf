variable "identifier" {
  default = ""
  type    = string
}

variable "allocated_storage" {
  type = number
}

variable "engine" {
  default = "mysql"
  type    = string
}

variable "engine_version" {
  default = "8.0"
  type    = string
}

variable "family" {
  default = "mysql8.0"
  type    = string
}

variable "name" {
  default = "datahub"
  type    = string
}

variable "instance_class" {
  default = "t3a.medium"
}

variable "db_name" {
  default = "datahub"
  type    = string
}

variable "username" {
  default = "root"
  type    = string
}

variable "maintenance_window" {
  default = "Mon:00:00-Mon:03:00"
  type    = string
}

variable "backup_window" {
  type    = string
  default = "03:00-06:00"
}

variable "monitoring_interval" {
  default = 60
  type    = number
}

variable "create_db_subnet_group" {
  default = false
  type    = bool
}

variable "subnet_ids" {
  default = ""
  type    = list(any)
}
