module "mysql" {
  source               = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  count                = var.database_type == "mysql" ? 1 : 0
  version              = "7.0.0"
  depends_on           = [module.sql_db_private_service_access]
  name                 = "${var.sql_instance_prefix}-${var.database_type}"
  random_instance_name = true
  project_id           = var.project_id
  database_version     = var.database_version
  region               = var.region
  // Master configurations
  tier                            = var.tier
  zone                            = var.zone
  availability_type               = var.instance_availability_type
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"
  deletion_protection             = var.env == "dev" ? false : true
  database_flags                  = lookup(local.read_replicas, "database_flags", [])
  ip_configuration                = lookup(local.read_replicas, "ip_configuration", {})
  backup_configuration            = var.backup_configuration

  // Read replica configurations
  read_replica_name_suffix = "-read-replica"

  read_replicas = [
    merge({ name = "0", zone = var.replica_zones.zone1 }, local.read_replicas),
    merge({ name = "1", zone = var.replica_zones.zone2 }, local.read_replicas)
  ]

  db_name      = var.database_name
  db_charset   = "UTF8"
  db_collation = "utf8_general_ci" //MYSQL supported collation (https://dev.mysql.com/doc/refman/5.7/en/charset-charsets.html)

  user_name     = var.admin_user
  user_password = var.root_password == "" ? "${var.database_type}-${random_password.root_password_sufix.result}" : var.root_password

  #Optional
  additional_databases = var.additional_databases
  additional_users     = var.database_users
}
