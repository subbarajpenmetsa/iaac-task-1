resource "aws_route53_zone" "private_route53_zone" {
  name = "example.com"
  vpc {
    vpc_id = aws_vpc.demovpc.id
  }
}

resource "aws_route53_record" "app" {
  zone_id = aws_route53_zone.private_route53_zone.zone_id
  name    = "app.example.com"
  type    = "A"

  alias {
    name                   = aws_lb.private_lb.dns_name
    zone_id                = aws_lb.private_lb.zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "db" {
  zone_id = aws_route53_zone.private_route53_zone.zone_id
  name    = "db.example.com"
  type    = "CNAME"
  records = ["${aws_db_instance.rds.address}"]
  ttl     = 300
}

