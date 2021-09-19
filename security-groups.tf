############################################
# Create public load balancer security group
############################################
resource "aws_security_group" "public_lb_sg" {
  name        = "public-lb-sg"
  description = "Security group for public load balancer"
  vpc_id      = aws_vpc.demovpc.id

  tags = { Name = "public-lb-sg" }
}

resource "aws_security_group_rule" "public_lb_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.public_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all egress"
}

resource "aws_security_group_rule" "public_lb_sg_igress_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.public_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all traffic on 80"
}

resource "aws_security_group_rule" "public_lb_sg_igress_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.public_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all traffic on 443"
}

############################################
# Create private load balancer security group
############################################
resource "aws_security_group" "private_lb_sg" {
  name        = "private-lb-sg"
  description = "Security group for private load balancer"
  vpc_id      = aws_vpc.demovpc.id

  tags = { Name = "private-lb-sg" }
}

resource "aws_security_group_rule" "private_lb_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.private_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all egress"
}

resource "aws_security_group_rule" "private_lb_sg_igress_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private_lb_sg.id
  source_security_group_id = aws_security_group.web_sg.id
  description              = "Allow traffic from web tier sg to private load balancer port 80"
}

############################################
# Create web tier security group
############################################
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group for web tier"
  vpc_id      = aws_vpc.demovpc.id

  tags = { Name = "web-sg" }
}

resource "aws_security_group_rule" "web_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.web_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all egress"
}

resource "aws_security_group_rule" "web_sg_igress_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = aws_security_group.public_lb_sg.id
  description              = "Allow traffic from public load balancer sg to web server port 80"
}

resource "aws_security_group_rule" "web_sg_igress_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.web_sg.id
  cidr_blocks       = ["202.185.203.199/32"]
  description       = "Allow ssh from my ip"
}

############################################
# Create app tier security group
############################################
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Security group for app tier"
  vpc_id      = aws_vpc.demovpc.id

  tags = { Name = "app-sg" }
}

resource "aws_security_group_rule" "app_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.app_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all egress"
}

resource "aws_security_group_rule" "app_sg_igress_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_sg.id
  source_security_group_id = aws_security_group.private_lb_sg.id
  description              = "Allow traffic from private load balancer sg to app server port 80"
}

resource "aws_security_group_rule" "app_sg_igress_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_sg.id
  source_security_group_id = aws_security_group.web_sg.id
  description              = "Allow ssh from my web tier security group"
}

############################################
# Create database tier security group
############################################
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group for database tier"
  vpc_id      = aws_vpc.demovpc.id

  tags = { Name = "rds-sg" }
}

resource "aws_security_group_rule" "rds_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rds_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all egress"
}

resource "aws_security_group_rule" "rds_sg_igress_3306" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.app_sg.id
  description              = "Allow traffic from app tier sg to rds port 3306"
}