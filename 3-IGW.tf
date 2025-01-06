resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.poc-vpc-cf.id

  tags = {
    Name = "coalfire_IGW"
  }
}


