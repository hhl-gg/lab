variable "numbers_list" {
  type = list(number)
}

variable "objects_list" {
  type = list(object({
    firstname = string
    lastname  = string
  }))
}

variable "numbers_map" {
  type = map(number)
}

variable "users" {
  type = list(object({
    username = string
    role = string
  }))
}

locals {
    double_numbers = [for num in var.numbers_list : num * 2]
    even_numbers = [for num in var.numbers_list : num if num % 2 == 0]
    first_names = [for p in var.objects_list : p.firstname]
    full_names = [
      for p in var.objects_list : "${p.firstname} ${p.lastname}"
    ]
    doubles_map = { for key, value in var.numbers_map : key => value * 2 }
    even_map = { for key, value in var.numbers_map : key =>
        value * 2 if value % 2 == 0
    }

    users_map = { 
        # combine all roles for each user
        for u in var.users : u.username => u.role...
    }
}

output "double_numbers" {
  value = local.double_numbers
}

output "even_numbers" {
  value = local.even_numbers
}

output "first_names" {
  value = local.first_names
}

output "full_names" {
  value = local.full_names
}

output "doubles_map" {
  value = local.doubles_map
}

output "even_map" {
  value = local.even_map
}

output "users_map" {
  value = local.users_map
}