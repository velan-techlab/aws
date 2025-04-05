resource "aws_vpc_peering_connection" "dev-app-vpc-peering" {
  
  peer_vpc_id   = aws_vpc.app-vpc.id
  vpc_id        = aws_vpc.dev-vpc.id
  auto_accept   = true
  tags = {
    Name = "dev-app-vpc-peering"
  }
}