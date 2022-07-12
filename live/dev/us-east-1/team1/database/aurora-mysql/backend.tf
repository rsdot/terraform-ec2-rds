terraform {
  backend "s3" {
    bucket         = "rsdot-team1-terraform-state"
    key            = "live/dev/us-east-1/team1/database/aurora-mysql/terraform.tfstate"
    region         = "us-east-1"

    dynamodb_table = "rsdot-team1-terraform-state-lock"
    encrypt        = true
  }
}

