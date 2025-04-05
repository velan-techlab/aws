resource "aws_vpc" "app-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "app-vpc"
  }
}

resource "aws_internet_gateway" "app-igw" {
  vpc_id = aws_vpc.app-vpc.id

  tags = {
    Name = "app-igw"
  }
}

resource "aws_subnet" "app-public-subnet-01" {
  vpc_id     = aws_vpc.app-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone_id = "aps1-az1"
  tags = {
    Name = "apps-public-subnet-01"
  }
}


resource "aws_subnet" "app-public-subnet-02" {
  vpc_id     = aws_vpc.app-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone_id = "aps1-az2"
  tags = {
    Name = "app-public-subnet-02"
  }
}


resource "aws_route_table" "app-public-subnet-01-02-rt" {
  vpc_id = aws_vpc.app-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app-igw.id
  }
  route {
    cidr_block = "10.1.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.dev-app-vpc-peering.id
  }
  tags = {
    Name = "app-public-subnet-01-02-rt"
  }
}



resource "aws_subnet" "app-private-subnet-01" {
  vpc_id     = aws_vpc.app-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone_id = "aps1-az1"
  tags = {
    Name = "app-private-subnet-01"
  }
}

resource "aws_subnet" "app-private-subnet-02" {
  vpc_id     = aws_vpc.app-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone_id = "aps1-az2"
  tags = {
    Name = "app-private-subnet-02"
  }
}

resource "aws_route_table" "app-private-subnet-01-02-rt" {
  vpc_id = aws_vpc.app-vpc.id
  tags = {
    Name = "app-private-subnet-01-02-rt"
  }
}

resource "aws_route_table_association" "aws_route_table_association_public_subnet_01" {
  subnet_id      = aws_subnet.app-public-subnet-01.id
  route_table_id = aws_route_table.app-public-subnet-01-02-rt.id
}

resource "aws_route_table_association" "aws_route_table_association_public_subnet_02" {
  subnet_id      = aws_subnet.app-public-subnet-02.id
  route_table_id = aws_route_table.app-public-subnet-01-02-rt.id
}

resource "aws_route_table_association" "aws_route_table_association_private_subnet_01" {
  subnet_id      = aws_subnet.app-private-subnet-01.id
  route_table_id = aws_route_table.app-private-subnet-01-02-rt.id
}

resource "aws_route_table_association" "aws_route_table_association_private_subnet_02" {
  subnet_id      = aws_subnet.app-private-subnet-02.id
  route_table_id = aws_route_table.app-private-subnet-01-02-rt.id
}