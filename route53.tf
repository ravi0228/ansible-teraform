resource "aws_route53_zone" "hosted_zone" {
  name = var.my_domain_name
}

locals {
  web_server_ip = aws_instance.web_server.*.public_ip
  mail_server_ip = aws_instance.mail_server.*.public_ip
  db_server_ip = aws_instance.db_server.*.public_ip
  httpd_server_ip = aws_instance.httpd_server.*.public_ip

}


resource "aws_route53_record" "mail" {
  zone_id = resource.aws_route53_zone.hosted_zone.zone_id
  name    = var.my_mail_sub_domain_name
  type    = "A"
  ttl     = 300
  records = [aws_instance.mail_server[0].public_ip]
}

resource "aws_route53_record" "db" {
  zone_id = resource.aws_route53_zone.hosted_zone.zone_id
  name    = var.my_db_sub_domain_name
  type    = "A"
  ttl     = 300
  records = [aws_instance.db_server[0].public_ip]
}

resource "aws_route53_record" "httpd" {
  zone_id = resource.aws_route53_zone.hosted_zone.zone_id
  name    = var.my_httpd_server_sub_domain_name
  type    = "A"
  ttl     = 300
  records = [aws_instance.httpd_server[0].public_ip]
}

resource "aws_route53_record" "web" {
  zone_id = resource.aws_route53_zone.hosted_zone.zone_id
  name    = var.my_web_sub_domain_name
  type    = "A"
  ttl     = 300
  records = [aws_instance.web_server[0].public_ip]
}
