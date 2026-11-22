resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2_volume_config.size
    volume_type = var.ec2_volume_config.type
  }

  tags = merge(local.common_tags, var.additional_tags, {
    Name = "tf-instance"
  })
}

resource "random_id" "project_bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = "${local.project}-${random_id.project_bucket_suffix.hex}"

  tags = merge(local.common_tags, var.additional_tags)
}