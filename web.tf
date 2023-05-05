resource "aws_instance" "web_server" {
  count = var.web_want == true ? var.web_count : 0
  ami           = "ami-007855ac798b5175e"
  instance_type = var.instance_type
  key_name      = var.my_key_name
  
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file(var.my_local_aws_private_key_path)
    host     = self.public_ip
  }

  tags = {
    Name = "Web_server-${count.index}"
  }  

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
      "cd /var/www/html",
      "sudo chmod 407 index.html",
      "sudo echo '<h1>Hello World from ravi Web_Server</h1>'  > /var/www/html/index.html",
      "sudo systemctl restart apache2"
    ]

  }  
}
