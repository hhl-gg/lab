terraform {
  backend "s3" {
    bucket       = "tf-s3-state-jhsdf7a564asdf65s76"
    region       = "eu-north-1"
    # key          = "dev/state.tfstate"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.9"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "random_string" "bucket_name" {
  length           = 30
  special          = true
  upper            = false
  override_special = "-"
}

# output "random" {
#   value = random_string.bucket_name.result
# }

resource "aws_s3_bucket" "tf_bucket" {
  bucket = "tf-s3-${random_string.bucket_name.result}"

  tags = {
    Name = "terraform"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.tf_bucket.bucket
}