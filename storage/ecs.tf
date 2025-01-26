# resource "aws_ecs_cluster" "my_cluster" {
#   name = "my-cluster"
# }

# resource "aws_ecs_task_definition" "my_task_definition" {
#   family                   = "my-task"
#   execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
#   task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]

#   container_definitions = jsonencode([{
#     name      = "my-container"
#     image     = "mydockerimage:latest"
#     cpu       = 256
#     memory    = 512
#     essential = true
#     portMappings = [{
#       containerPort = 8080
#       hostPort      = 8080
#       protocol      = "tcp"
#     }]
#   }])
# }

# resource "aws_ecs_service" "my_service" {
#   name            = "my-service"
#   cluster         = aws_ecs_cluster.my_cluster.id
#   task_definition = aws_ecs_task_definition.my_task_definition.arn
#   desired_count   = 1

#   network_configuration {
#     subnets          = ["subnet-12345678"]  # Replace with your subnet
#     security_groups = ["sg-12345678"]      # Replace with your security group
#     assign_public_ip = true
#   }
# }

# resource "aws_iam_role" "ecs_task_execution_role" {
#   name = "ecs-task-execution-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action    = "sts:AssumeRole"
#       Principal = {
#         Service = "ecs-tasks.amazonaws.com"
#       }
#       Effect    = "Allow"
#     }]
#   })
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }