terraform {
  backend "s3" {
    bucket         = "rsdot-team1-terraform-state"
    key            = "globals/team1/iam/aurora-access-s3/terraform.tfstate"
    region         = "us-east-1"

    dynamodb_table = "rsdot-team1-terraform-state-lock"
    encrypt        = true
  }
}

