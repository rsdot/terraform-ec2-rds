#--------------------------------------------------------------------------------
# process step 1 start
#--------------------------------------------------------------------------------
resource "aws_s3_bucket" "terraform_state" {
  # bucket name doesn't take underscores
  bucket = "${var.namespace}-terraform-state"

  # Prevent accidential deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    migrationteam = var.namespace
  }
}

# Enable versioning, so can be reverted back to older versions if needed
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block all public access to this S3 bucket
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Strong consistent reads and conditional writes
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "${var.namespace}-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID" # has to be this name with case sensitive

  attribute {
    name = "LockID" # has to be this name with case sensitive 
    type = "S"
  }

  tags = {
    migrationteam = var.namespace
  }
}
#--------------------------------------------------------------------------------
# process step 1 complete, run terraform init and apply in order to generate local tfstate file
#--------------------------------------------------------------------------------


#--------------------------------------------------------------------------------
# process step 2 start
#--------------------------------------------------------------------------------
terraform {
  backend "s3" {
    bucket         = "rsdot-team1-terraform-state"
    key            = "globals/team1/remote-state/terraform.tfstate"
    region         = "us-east-1"

    dynamodb_table = "rsdot-team1-terraform-state-lock"
    encrypt        = true
  }
}
#--------------------------------------------------------------------------------
# process step 2 complete, run terraform init and apply in order to upload local tfstage file to S3 bucket
#--------------------------------------------------------------------------------

