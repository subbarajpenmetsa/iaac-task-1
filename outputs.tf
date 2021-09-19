output "public_lb_endpoint" {
  value = aws_lb.public_lb.dns_name
}

output "private_lb_endpoint" {
  value = aws_lb.private_lb.dns_name
}

output "app_endpoint_private" {
  value = aws_route53_record.app.name
}

output "db_endpoint_private" {
  value = aws_route53_record.db.name
}