# IAM Policy Document for assuming a role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# IAM Policy Document for ECS Task Execution
data "aws_iam_policy_document" "ecs_task_execution_policy_document" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["*"]
  }

  # create an inline policy to access s3 object and get bucket location
  statement {
    actions = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.project_name}-${var.env_file_bucket_name}/*"]
  }

  statement {
    actions = ["s3:GetBucketLocation"]
    resources = ["arn:aws:s3:::${var.project_name}-${var.env_file_bucket_name}"]
  }
}

# IAM Policy for ECS Task Execution
resource "aws_iam_policy" "ecs_task_execution_policy" {
  name   = "${var.project_name}-${var.environment}-ecs-task-execution-policy"
  policy = data.aws_iam_policy_document.ecs_task_execution_policy_document.json
}

# create an IAM role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.project_name}-${var.environment}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# Attach ECS Task Execution Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}