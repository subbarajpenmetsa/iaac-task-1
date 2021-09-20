resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.demo_private_subnet_1.id, aws_subnet.demo_private_subnet_2.id]

  tags = { Name = "RDS DB subnet group" }
}

# Retriving DB credentials from AWS Secret Manager

data "aws_secretsmanager_secret_version" "username" {
  secret_id = "db-username"

}

data "aws_secretsmanager_secret_version" "password" {
  secret_id = "db-password"

}

#Creating mysql rds instances
resource "aws_db_instance" "rds" {
  identifier             = "rds"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  name                   = "mydb"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.id
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  username               = local.db_username.username
  password               = local.db_creds.password

  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
