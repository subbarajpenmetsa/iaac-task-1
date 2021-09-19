resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.demo_private_subnet_1.id, aws_subnet.demo_private_subnet_2.id]

  tags = { Name = "RDS DB subnet group" }
}


# resource "random_password" "master"{
#   length           = 16
#   special          = true
#   override_special = "_!%^"
# }

# resource "aws_secretsmanager_secret" "password" {
#   name = "test-db-password"
# }

# resource "aws_secretsmanager_secret_version" "password" {
#   secret_id = aws_secretsmanager_secret.password.id
#   secret_string = {
#     password= random_password.master.result}
# }

# resource "aws_secretsmanager_secret_version" "example" {
#   secret_id     = aws_secretsmanager_secret.example.id
#   secret_string = jsonencode(var.example)
# }

# Retriving DB password from AWS Secret Manager

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
  username               = var.rds_admin
  password               = local.db_creds.password

  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}