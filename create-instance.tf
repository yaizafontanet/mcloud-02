resource "aws_iam_role" "ecs_task_execution_role" {
  name = "role-name"
 
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

resource "aws_iam_role" "ecs_task_role" {
  name = "role-name-task"
 
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

resource "aws_iam_role_policy_attachment" "task_s3" {
  role       = "${aws_iam_role.ecs_task_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_ecs_task_definition" "definition" {}

resource "aws_ecs_task_definition" "definition" {
  family                   = "task_definition_name"
  task_role_arn            = "${var.ecs_task_role}"
  execution_role_arn       = "${var.ecs_task_execution_role}"
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "1024"
  requires_compatibilities = ["FARGATE"]
}

container_definitions = <<DEFINITION
[
  {
    "image": "${var.account}.dkr.ecr.eu-west-1.amazonaws.com/project:latest",
    "name": "project-container",
    "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-region" : "eu-east-1",
                    "awslogs-group" : "stream-to-log-fluentd",
                    "awslogs-stream-prefix" : "project"
                }
            },
    "secrets": [{
        "name": "secret_variable_name",
        "valueFrom": "arn:aws:ssm:region:acount:parameter/parameter_name"
    }],           
    "environment": [
            {
                "name": "bucketName",
                "value": "${var.bucket_name}"
            },
            {
                "name": "folder",
                "value": "${var.folder}"
            }
        ]
    }
  
]
DEFINITION
}