terraform {
    required_providers {
        aws = {
            version = "~> 3.26"
            source  = "hashicorp/aws"
        }
    }
    backend "s3" {
        bucket         = "terraform-state-repte-2"
        key            = "terra-backend/terraform.tfstate"
        encrypt        = true
        region         = "us-east-1"
        dynamodb_table = "terraform-state-locking"
    }
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
}
