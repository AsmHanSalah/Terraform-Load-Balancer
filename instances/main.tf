resource "aws_instance" "public_instance" {
  ami                   = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = var.public_subnet_id
  security_groups       = [var.public_sg_id]
  key_name              = var.key_name

  tags = {
    Name = "bastion-host"
  }

  provisioner "file" {
    content = file("${path.root}/${var.key_name}.pem")
    destination = "/home/ubuntu/.ssh/${var.key_name}.pem"
  }
   connection {
    type        = "ssh"
    user        = "ubuntu"                        
    private_key = file("${path.root}/${var.key_name}.pem")
    host        = self.public_ip
  } 
}

resource "aws_instance" "private_instance_1" {
  ami                    = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = var.private_subnet_1_id
  security_groups       = [var.private_sg_id]
  key_name              = var.key_name

  user_data = <<-EOT
      #!/bin/bash
      sudo apt update -y
      sudo apt install nginx -y
      sudo systemctl start nginx
      sudo systemctl enable nginx
      sudo service nginx restart
    EOT

  tags = {
    Name = "private-1 "
  }

}

resource "aws_instance" "private_instance_2" {
  ami                    = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = var.private_subnet_2_id
  security_groups       = [var.private_sg_id]
  key_name              = var.key_name

   user_data = <<-EOT
      #!/bin/bash
      sudo apt update -y
      sudo apt install nginx -y
      sudo systemctl start nginx
      sudo systemctl enable nginx
      sudo service nginx restart
    EOT

  tags = {
    Name = "private-2 "
  }
}
