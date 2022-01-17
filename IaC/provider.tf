terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  default_tags {
    tags = {
      Team = "Team7"
    }
  }
}

terraform {
  backend "s3" {
    key    = "terraform/terraform.tfstate"
    bucket = "mafia-app-terraform-statefile"
    region = "us-east-1"
  }
}