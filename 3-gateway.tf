# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Prof_Cloud_VPC.id

  tags = {
    Name = "Prof Cloud Internet Gateway"
  }
}

#Elastic IP for NAT
resource "aws_eip" "maineip" {
  domain = "vpc"

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "Prof Cloud Elastic EIP"
  }
}

#NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.maineip.id

  #Use the first public subnet
  subnet_id = aws_subnet.public_subnet[0].id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "Proj Cloud NAT Gateway"
  }
}