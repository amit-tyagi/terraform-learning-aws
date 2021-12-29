terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.70.0"
    }
  }

  backend "s3" {
    region            = "us-east-1"
    profile           = "terraform-admin"
#    dynamodb_table    = "terraform-state-lock-table"
  }

}

provider "aws" {
  region = "us-east-1"
  profile = "terraform-admin"
}