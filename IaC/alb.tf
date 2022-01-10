
   
# resource "aws_lb" "test-lb" {
#   name               = "test-ecs-lb"
#   load_balancer_type = "application"
#   internal           = false
#   subnets            = module.vpc.public_subnets
#   tags = {
#     "env"       = "dev"
#     "createdBy" = "mkerimova"
#   }
#   security_groups = [aws_security_group.lb.id]
# }