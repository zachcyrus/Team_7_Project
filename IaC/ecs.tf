
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
resource "aws_ecs_task_definition" "MafiaApp-ecs-task-definition" {
  family                   = "MafiaApp"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::649474668035:role/ecsTaskExecutionRole"
  memory                   = "1024"
  cpu                      = "512"
  container_definitions    = <<EOF
[
  {
    "name": "test-app",
    "image": "649474668035.dkr.ecr.us-east-1.amazonaws.com/test-app:1.59",
    "memory": 1024,
    "cpu": 512,
    "essential": true,
    "entryPoint": ["/"],
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
