# VPC For our Mafia Application
# Creates:
# 3 Public Subnets
# 3 Private Subnets
# 1 Internet Gateway
# 1 Route Table for the (3) Public Subnets
# 3 Route Tables for each Private Subnet

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Mafia_App"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]


  tags = {
    Terraform = "true"
  }
}