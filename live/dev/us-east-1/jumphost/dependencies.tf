data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "rsdot-team1-terraform-state"
    key    = "live/dev/us-east-1/network/terraform.tfstate"
    region = "us-east-1"
  }
}

