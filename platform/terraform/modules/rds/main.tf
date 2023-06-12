module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.name

  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_types
  allocated_storage = var.allocated_storage

  db_name  = var.db_name
  username = var.username
  port     = var.username

  vpc_security_group_ids = var.vpc_security_group_ids

  maintenance_window      = var.maintenance_window
  backup_window           = var.backup_window
  backup_retention_period = var.backup_retention_period

  monitoring_interval    = var.monitoring_interval
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  # DB subnet group
  create_db_subnet_group = var.create_db_subnet_group
  subnet_ids             = var.subnet_ids
}