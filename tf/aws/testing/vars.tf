terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

variable "bucket_name" {
  type = string
  description = "Bucket name"
  default = "tf-managed-bucket-001"
}

data "aws_s3_bucket" "external_bucket" {
  bucket = "tf-s3-bucket-test-1"
}

resource "aws_s3_bucket" "tf_bucket" {
  bucket = var.bucket_name
}

output "bucket_id" {
  value = aws_s3_bucket.tf_bucket.id
}

locals {
  local_example = "This is a local variable"
}