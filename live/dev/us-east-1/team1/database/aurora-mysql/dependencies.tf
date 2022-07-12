#--------------------------------------------------------------------------------
# ref https://github.com/terraform-aws-modules/terraform-aws-rds-aurora
#--------------------------------------------------------------------------------
data "terraform_remote_state" "aurora_mysql_parameter_group" {
  backend = "s3"

  config = {
    bucket = "rsdot-team1-terraform-state"
    key    = "live/dev/us-east-1/team1/database/aurora-mysql/parameter-group/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "rsdot-team1-terraform-state"
    key    = "live/dev/us-east-1/network/terraform.tfstate"
    region = "us-east-1"
  }
}

