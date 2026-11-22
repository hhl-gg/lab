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

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "region" {}

data "aws_vpc" "managed" {
  tags = {
    Env = "development"
  }
}

output "ubuntu_ami" {
  value = data.aws_ami.ubuntu.id
}

output "region" {
  value = data.aws_region.region.region
}

output "account" {
  value = data.aws_caller_identity.current.id
}

output "vpc" {
  value = data.aws_vpc.managed.tags.Name
}