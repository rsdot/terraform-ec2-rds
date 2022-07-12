data "aws_caller_identity" "current" {}

locals {
  principal_arns = var.principal_arns != null ? var.principal_arns : [data.aws_caller_identity.current.arn]
}

data "aws_iam_policy_document" "s3_bucket_terraform_state_policy_document" {
  statement {
    actions = [
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.terraform_state.arn
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]

    resources = [
      aws_dynamodb_table.terraform_state_lock.arn
    ]
  }
}


resource "aws_iam_policy" "s3_bucket_terraform_state_s3_policy" {
  name = "${var.namespace}-s3-bucket-terraform-state-s3-policy"
  policy = data.aws_iam_policy_document.s3_bucket_terraform_state_policy_document.json

  tags = {
    migrationteam = var.namespace
  }
}

resource "aws_iam_role" "s3_bucket_terraform_state_s3_role" {
  name = "${var.namespace}-s3-bucket-terraform-state-s3-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = local.principal_arns
        }
      },
    ]
  })

  tags = {
    migrationteam = var.namespace
  }
}

resource "aws_iam_role_policy_attachment" "s3_bucket_terraform_state_s3_role_policy_attachment" {
  role = aws_iam_role.s3_bucket_terraform_state_s3_role.name
  policy_arn = aws_iam_policy.s3_bucket_terraform_state_s3_policy.arn
}

