variable "ec2_instance_type" {
    type = string
    default = "t3.micro"
    description = "EC2 Instance type to use"

    validation {
      # condition = contains(["t2.micro", "t3.micro", "t3.small"], var.ec2_instance_type)
      condition = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
      error_message = "Only t2.micro and t3.micro are allowed"
    }
}

variable "ec2_volume_type" {
  type = string
  description = "Volume type"
  default = "gp3"
}

variable "ec2_volume_size" {
  type = number
  description = "Volume size"
  default = 10
}

variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })
  description = "The size and type of root block volume"

  default = {
    size = 10
    type = "gp3"
  }
}

variable "additional_tags" {
  type = map(string)
  default = {
    ManagedBy = "terraform"
  }
}

