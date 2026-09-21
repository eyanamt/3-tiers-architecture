############################################################
# BASE DE DONNÉES (ex 05-database.yaml)
############################################################

resource "aws_db_subnet_group" "main" {
  name        = "${var.environment_name}-db-subnet-group"
  description = "Sous-réseaux privés isolés pour RDS"
  subnet_ids  = [aws_subnet.data_1.id, aws_subnet.data_2.id]

  tags = {
    Name = "${var.environment_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier     = "${var.environment_name}-db"
  engine         = "mysql"
  engine_version = "8.0"

  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage

  username = var.db_username
  password = var.db_password

  multi_az                = true
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.db.id]
  publicly_accessible     = false
  backup_retention_period = 7
  storage_encrypted       = true

  # Équivalent de DeletionPolicy/UpdateReplacePolicy: Snapshot dans le CFN
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.environment_name}-db-final-snapshot"

  tags = {
    Name = "${var.environment_name}-db"
  }
}
