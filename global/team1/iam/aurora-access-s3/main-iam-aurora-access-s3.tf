data "aws_iam_policy_document" "aurora_access_s3_policy_document" {
  statement {
    sid = "AllowAuroraToS3Bucket"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetEncryptionConfiguration", # if stored in S3 encrypted
      # "s3:GetAccess*",
      # "s3:GetStorage*",
      # "s3:GetObject*",
      # "s3:GetBucket*",
      "s3:Get*",
      "s3:ListBucket",
      "s3:ListMultipartUploadParts"
    ]
    resources = [
      "arn:aws:s3:::rsdot-team1-xtrabackup/*",
      "arn:aws:s3:::rsdot-team1-xtrabackup"
    ]
  }
}

resource "aws_iam_policy" "aurora_access_s3_policy" {
  name = "${var.namespace}-aurora-access-s3-policy"
  policy = data.aws_iam_policy_document.aurora_access_s3_policy_document.json

  tags = {
    migrationteam = var.namespace
  }
}

resource "aws_iam_role" "aurora_access_s3_role" {
  name = "${var.namespace}-aurora-access-s3-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    migrationteam = var.namespace
  }
}

resource "aws_iam_role_policy_attachment" "aurora_access_s3_role_policy_attachment" {
  role = aws_iam_role.aurora_access_s3_role.name
  policy_arn = aws_iam_policy.aurora_access_s3_policy.arn
}

