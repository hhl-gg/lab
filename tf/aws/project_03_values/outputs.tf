output "s3_bucket_name" {
  value = aws_s3_bucket.project_bucket.bucket
  sensitive = true
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

output "secret" {
  sensitive = true
  value = var.secret
}