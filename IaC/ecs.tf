
#Creating ECS Cluster
resource "aws_ecs_cluster" "MafiaApp" {
  name = "ecs-cluster-for-MafiaApplication"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
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
    security_groups = [
      aws_security_group.ecs-tasks-sg.id,
      aws_security_group.lb_security_group.id

    ]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "test-app"
    container_port   = 5000
  }
  desired_count = 1
  depends_on = [
    aws_lb_listener.lb_listener
  ]
}

## Creating Task Definition
## Remember to terraform the ecr image
resource "aws_ecs_task_definition" "MafiaApp-ecs-task-definition" {
  family                   = "MafiaApp"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  memory                   = "1024"
  cpu                      = "512"
  container_definitions    = <<EOF
[
  {
    "name": "test-app",
    "image": "649474668035.dkr.ecr.us-east-1.amazonaws.com/test-app:1.106",
    "memory": 1024,
    "cpu": 512,
    "essential": true,
    "entryPoint": [],
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ]
  }
]
EOF
}

resource "aws_security_group" "ecs-tasks-sg" {
  name   = "ecs-task-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    security_groups  = [aws_security_group.lb_security_group.id]
  }

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