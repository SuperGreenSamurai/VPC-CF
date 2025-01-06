resource "aws_launch_template" "apache-web" {
  name                   = "${var.name_prefix}apache-web" 
  image_id               = var.instance_ami               # RedHat Linux AMI ID
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.server_sg.id]


  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = var.volume_size #20 GB
    }
  }
   user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd
    systemctl start httpd
    systemctl enable httpd
      EOF
  )

  tags = {
    Name = "apache-web-servers"
  }

  lifecycle {
    create_before_destroy = true
  }
}

