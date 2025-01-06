#private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.poc-vpc-cf.id

  route {

    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private"
  }
}

#public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.poc-vpc-cf.id
  route {
    cidr_block = var.public_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public"
  }
}

#route table associations

#public Subnets 1-2
resource "aws_route_table_association" "public-us-west-2a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-west-2b" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public.id
}

#private Subnets 3-4
resource "aws_route_table_association" "private-us-west-2a" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-us-west-2b" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.private.id
}