terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }

    random = {
        source = "hashicorp/random"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

locals {
  project = "terraform-playground"
  project_owner = "test@company.com"
  managed_by = "terraform"

  common_tags = {
    project = local.project
    project_owner = local.project
    managed_by = local.managed_by
    secret = var.secret
  }
}