resource "aws_s3_bucket" "xtrabackup" {
  # bucket name doesn't take underscores
  bucket = "${var.namespace}-xtrabackup"

  # Don't prevent accidential deletion of this S3 bucket
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    migrationteam = var.namespace
  }
}

# Disable versioning
resource "aws_s3_bucket_versioning" "disabled" {
  bucket = aws_s3_bucket.xtrabackup.id
  versioning_configuration {
    status = "Disabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.xtrabackup.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block all public access to this S3 bucket
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.xtrabackup.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

