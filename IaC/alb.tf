
   
# resource "aws_lb" "test-lb" {
#   name               = "test-ecs-lb"
#   load_balancer_type = "application"
#   internal           = false
#   subnets            = module.vpc.public_subnets
#   tags = {
#   }
#   security_groups = [aws_security_group.lb.id]
# }

# resource "aws_security_group" "lb" {
#   name   = "allow-all-lb"
#   vpc_id = data.aws_vpc.main.id
#   ingress {
#     from_port   = 5000
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
