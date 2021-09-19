variable "aws_region" {
  description = "AWS region to create vpc and its components and resources"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Instance type for all type of servers web, app & db"
  type        = string
  default     = "t2.micro"
}

variable "rds_admin" {
  type        = string
  description = "username for rds admin user"
  default     = ""
  sensitive   = true
}

# variable "rds_password" {
#   type        = string
#   description = "password for rds admin user"
#   default     = ""
#   sensitive   = true
# }

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.password.secret_string
  )
}