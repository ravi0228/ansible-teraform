resource "aws_instance" "mail_server" {
  count = var.mail_want == true ? var.mail_count : 0 
  ami           = "ami-03a933af70fa97ad2"
  instance_type = var.instance_type
  key_name      = var.my_key_name
  
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file(var.my_local_aws_private_key_path)
    host     = self.public_ip
  }

  tags = {
    Name = "mail_server-${count.index}"
  }  

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
      "cd /var/www/html",
      "sudo chmod 407 index.html",
      "sudo echo '<h1>Hello World from ravi Mail_Server</h1>' > /var/www/html/index.html",
      "sudo systemctl restart apache2"
    ]

  }  
}
