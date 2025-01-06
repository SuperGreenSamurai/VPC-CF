#public subnets

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.poc-vpc-cf.id
  cidr_block              = var.sub1
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name   = "us-west-2a"
    subnet = "public"


  }

}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.poc-vpc-cf.id
  cidr_block              = var.sub2
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name   = "us-west-2b"
    subnet = "public"

  }
}


#private subnets

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.poc-vpc-cf.id
  cidr_block              = var.sub3
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name   = "us-west-2a"
    subnet = "private"

  }
}


resource "aws_subnet" "subnet4" {
  vpc_id            = aws_vpc.poc-vpc-cf.id
  cidr_block        = var.sub4
  availability_zone = var.az2

  tags = {
    Service = "us-west-2b"
    Name    = "private"

  }
}


