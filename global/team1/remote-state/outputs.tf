output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_state_lock.name
}

output "iam_role_arn" {
  value = aws_iam_role.s3_bucket_terraform_state_s3_role.arn
}
