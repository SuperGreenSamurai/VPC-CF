resource "aws_security_group" "server_sg" {
  name   = "security-group-server"
  vpc_id = aws_vpc.poc-vpc-cf.id

  ingress {
    description = "Homepage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr_block] #allow all
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr_block] #allow all
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_cidr_block] #allow all
  }

}

#######################################################
#Load Balancer Security Group


resource "aws_security_group" "lb_sg" {
  name   = "security-group-lb"
  vpc_id = aws_vpc.poc-vpc-cf.id

  ingress {
    description = "LB-Ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr_block] #allow all
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_cidr_block] #allow all
  }

  tags = {
    Name = "sg-lb"
    env  = "Lb-Security-Group"
  }
}