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
  }

}

provider "aws" {
  region = "us-east-1"
  profile = "terraform-admin"
}