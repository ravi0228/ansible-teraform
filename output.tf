
output "web_server_public_ip" {
  value = aws_instance.web_server.*.public_ip
}

output "mail_server_public_ip" {
  value = aws_instance.mail_server.*.public_ip
}

output "db_server_public_ip" {
  value = aws_instance.db_server.*.public_ip
}

output "httpd_server_public_ip" {
  value = aws_instance.httpd_server.*.public_ip
}
