
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
    subnets          = [""]
    assign_public_ip = true
  }
  desired_count = 1
}

#Creating Task Definition
resource "aws_ecs_task_definition" "MafiaApp-ecs-task-definition" {
  family                   = "MafiaApp"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "1024"
  cpu                      = "512"
  container_definitions    = <<EOF
[
  {
    "name": "",
    "image": "123456789012.dkr.ecr.us-east-1.amazonaws.com/demo-repo:1.0",
    "memory": 1024,
    "cpu": 512,
    "essential": true,
    "entryPoint": ["/"],
    "portMappings": [
      {
        "containerPort": ,
        "hostPort": 
      }
    ]
  }
]
EOF
}