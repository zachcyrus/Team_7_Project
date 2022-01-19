
#Creating ECS Cluster
resource "aws_ecs_cluster" "MafiaApp" {
  name = "ecs-cluster-for-MafiaApplication"
}

#Creating ECS Service 
resource "aws_ecs_service" "Mafia-ecs-service" {
  name            = "Mafia-app"
  cluster         = aws_ecs_cluster.MafiaApp.id
  task_definition = aws_ecs_task_definition.MafiaApp-ecs-task-definition.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = ["${module.vpc.public_subnets[0]}"]
    assign_public_ip = true
  }
  desired_count = 1
}

#Creating Task Definition
# resource "aws_ecs_task_definition" "MafiaApp-ecs-task-definition" {
#   family                   = "MafiaApp"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   execution_role_arn       = "arn:aws:iam::649474668035:role/ecsTaskExecutionRole"
#   memory                   = "1024"
#   cpu                      = "512"
#   container_definitions    = <<EOF
# [
#   {
#     "name": "test-app",
#     "image": "649474668035.dkr.ecr.us-east-1.amazonaws.com/test-app:1.96",
#     "memory": 1024,
#     "cpu": 512,
#     "essential": true,
#     "entryPoint": ["/"],
#     "portMappings": [
#       {
#         "containerPort": 5000,
#         "hostPort": 5000
#       }
#     ]
#   }
# ]
# EOF
# }

#Creating Task Definition
resource "aws_ecs_task_definition" "MafiaApp-ecs-task-definition" {
  family                   = "MafiaAppTestDefinition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "test-app",
    "image": "649474668035.dkr.ecr.us-east-1.amazonaws.com/test-app:1.96",
    "cpu": 512,
    "memory": 1024,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
}

resource "aws_security_group" "ecs_tasks" {
  name   = "ecs-task-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = 5000
    to_port          = 5000
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name = "MafiaApp-ecsTaskExecutionRole"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}