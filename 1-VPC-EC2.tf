resource "aws_vpc" "poc-vpc-cf" {
  cidr_block           = var.cidr_block_vpc
  enable_dns_support   = true # Enable DNS support
  enable_dns_hostnames = true # Enable DNS hostnames

  tags = {
    Name   = "Coalfire"
    Client = "tbd"

  }
}

#stand alone EC2 instance
resource "aws_instance" "web" {
  ami               = var.instance_ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  availability_zone = var.az2
  subnet_id         = aws_subnet.subnet2.id
  monitoring        = true


  depends_on = [aws_launch_template.apache-web]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = {
    Name = "web-server"
    Key  = "stand-alone-instance"
    role = "ssh"
  }
}
