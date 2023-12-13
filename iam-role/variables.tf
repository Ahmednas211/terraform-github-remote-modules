variable "project_name" {}
variable "env_file_bucket_name" {}
variable "environment" {}
variable "env_file_name" {}

#  resources = [
#       "arn:aws:s3:::${var.project_name}-${var.env_file_bucket_name}/*"  # This is the ARN of the s3 bucket, because we want the ECS service to the get any object from this s3 bucket
#     ]