terraform {
    required_providers {
        aws = {
        version = "~> 3.26"
        source  = "hashicorp/aws"
        }
    }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}