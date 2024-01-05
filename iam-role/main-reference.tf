# # create iam policy document. this policy allows the ecs service to assume a role
# data "aws_iam_policy_document" "assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }

# # create iam policy document
# data "aws_iam_policy_document" "ecs_task_execution_policy_document" {
#   statement {
#     actions = [
#       "ecr:GetAuthorizationToken",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:GetDownloadUrlForLayer",
#       "ecr:BatchGetImage",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents"
#     ]

#     resources = ["*"]
#   }

#   # Statement for Amazon EC2 Container Registry read-only permissions
# statement {
#   actions = [
#     "ecr:GetAuthorizationToken",
#     "ecr:BatchCheckLayerAvailability",
#     "ecr:GetDownloadUrlForLayer",
#     "ecr:GetRepositoryPolicy",
#     "ecr:DescribeRepositories",
#     "ecr:ListImages",
#     "ecr:DescribeImages",
#     "ecr:BatchGetImage",
#     "ecr:GetLifecyclePolicy",
#     "ecr:GetLifecyclePolicyPreview",
#     "ecr:ListTagsForResource",
#     "ecr:DescribeImageScanFindings",
#     "logs:CreateLogStream",
#     "logs:PutLogEvents"
#   ]
#   resources = ["*"]
# }

# # create an inline policy to access s3 object and get bucket location
#   statement {
#     actions = [
#       "s3:GetObject"
#     ]

#     resources = [
#       "arn:aws:s3:::${var.project_name}-${var.env_file_bucket_name}/*"  # This is the ARN of the s3 bucket, because we want the ECS service to the get any object from this s3 bucket
#     ]
#   }
  
#   statement {
#     actions = [
#       "s3:GetBucketLocation"  # we want the ECS service the get the s3 location.
#     ]

#     resources = [
#       "arn:aws:s3:::${var.project_name}-${var.env_file_bucket_name}"  # Here, we want the ARN of the s3 bucket -- just like what we did in line 34
#     ]
#   }
# } 

# # create iam policy and attach ecs task execution policy document
# resource "aws_iam_policy" "ecs_task_execution_policy" {
#   name   = "${var.project_name}-${var.environment}-ecs-task-execution-role-policy" # the variable here is our typical project name and environmnet information
#   policy = data.aws_iam_policy_document.ecs_task_execution_policy_document.json
# }

# # create an iam role
# resource "aws_iam_role" "ecs_task_execution_role" {
#   name               = "${var.project_name}-${var.environment}-ecs-task-execution-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
# }

# # attach ecs task execution policy to the iam role
# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
# }
