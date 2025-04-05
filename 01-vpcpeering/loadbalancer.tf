resource "aws_lb" "test" {
  name               = "test-alb-tf"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.app-public-subnet-01.id,aws_subnet.app-public-subnet-02.id]

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.id
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = "test"
  }
}