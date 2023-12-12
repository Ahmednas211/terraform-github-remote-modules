# create an s3 bucket 
resource "aws_s3_bucket" "env_file_bucket" {
  bucket = "${var.project_name}-${var.env_file_bucket_name}"

  lifecycle {
    create_before_destroy = false
  }
}

# upload the environment file from local computer into the s3 bucket
resource "aws_s3_object" "upload_env_file" {
  count   = fileexists("./${var.env_file_name}") ? 1 : 0
  bucket  = aws_s3_bucket.env_file_bucket.id
  key     = var.env_file_name
  source  = "./${var.env_file_name}"
}

# # upload the environment file from local computer into the s3 bucket
# resource "aws_s3_object" "upload_env_file" {
#   bucket = aws_s3_bucket.env_file_bucket.id
#   key    = var.env_file_name
#   source = "./${var.env_file_name}"
# }