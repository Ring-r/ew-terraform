terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48.0"
    }
  }

  backend "s3" {
    bucket = "tfstate-1c0f6c75-859b-4bcb-a054-a08019b06260"
    key    = "common/terraform_backend_s3_bucket.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform-backend-s3-bucket" {
  bucket = "tfstate-1c0f6c75-859b-4bcb-a054-a08019b06260"
}
